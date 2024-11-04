import sys
import socket
import numpy as np
from PyQt5.QtWidgets import QApplication, QLabel, QMainWindow, QPushButton
from PyQt5.QtGui import QImage, QPixmap
from PyQt5.QtCore import Qt
from PyQt5.QtCore import Qt, QDateTime

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("VexGBA：像素传说")
        self.setGeometry(300, 300, 1600, 880)  # 窗口足够大以容纳 LOGO 和图像

        # 设置显示图像的标签
        self.image_label = QLabel(self)
        self.image_label.setGeometry(360, 40, 240*5, 160*5)  # 放大5倍

        # 设置 LOGO 区域
        self.logo_label = QLabel(self)
        pixmap = QPixmap(r"F:/2024FPGA/logo.png")
        if pixmap.isNull():
            print("图像加载失败，请检查路径")
        else:
            self.logo_label.setPixmap(pixmap.scaled(268, 120, Qt.KeepAspectRatio))
        #self.logo_label.setPixmap(QPixmap("E:/FPGA_2024/logo.png").scaled(268, 120, Qt.KeepAspectRatio))
        self.logo_label.setGeometry(50, 10, 268, 120)  # 根据实际窗口调整位置

        # 添加队伍编号和说明文字
        self.team_label = QLabel("队伍编号：6191\n", self)
        self.team_label.setGeometry(50, 140, 268, 60)  # 设置文字区域
        self.team_label.setStyleSheet("font-size: 28px; color: black;")  # 设置字体样式
        self.team_name_label = QLabel("队伍名称：\n就爱待在好利来\n", self)
        self.team_name_label.setGeometry(50, 240, 268, 60)
        self.team_name_label.setStyleSheet("font-size: 28px; color: black;")
        self.work_label = QLabel("作品名称：\nVexGBA：像素传说\n", self)
        self.work_label.setGeometry(50, 380, 268, 60)
        self.work_label.setStyleSheet("font-size: 28px; color: black;")

        # 增加显示“荣誉截屏完成”文本的标签
        self.text_display = QLabel(self)
        self.text_display.setGeometry(50, 600, 268, 100)
        self.text_display.setStyleSheet("font-size: 18px; color: green;")
        self.text_display.setWordWrap(True)

        # 设置 UDP 通信
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.sock.bind(("192.168.3.3", 32768))  # 根据需求调整端口
        # self.sock.bind(("0.0.0.0", 32768))  # 根据需求调整端口
        self.sock.setblocking(False)

        # 增加UDP接收缓冲区大小
        #self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 65536)  # 设置64KB缓冲区
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 262144)

        # 图像缓冲区，初始化为全黑
        self.image_data = np.zeros((160, 240, 3), dtype=np.uint8)
        self.udp_enabled = False  # UDP接收默认关闭

        # 初始化时显示全黑图像
        self.update_display()

        # 添加捕获按钮
        self.capture_button = QPushButton("开始捕获", self)
        self.capture_button.setGeometry(50, 500, 150, 50)
        self.capture_button.setStyleSheet("font-size: 20px;")
        self.capture_button.clicked.connect(self.toggle_udp_capture)
        

        # 设置定时器，定时检查接收数据
        self.timer = self.startTimer(15)  # 每30ms刷新一次

    def update_display(self):
        """将当前 image_data 内容显示在界面上"""
        qimg = QImage(self.image_data.data, 240, 160, QImage.Format_RGB888)
        qimg = qimg.scaled(240*5, 160*5, Qt.KeepAspectRatio)
        self.image_label.setPixmap(QPixmap.fromImage(qimg))

    def toggle_udp_capture(self):
        """切换UDP数据捕获状态"""
        self.udp_enabled = not self.udp_enabled
        if self.udp_enabled:
            self.capture_button.setText("停止捕获")
        else:
            self.capture_button.setText("开始捕获")
            self.image_data.fill(0)  # 捕获停止时将图像清空
            self.update_display()

    def timerEvent(self, event):
        if not self.udp_enabled:
            return  # 如果未启用UDP捕获，跳过接收数据

        try:
            data, _ = self.sock.recvfrom(961)  # 每帧为 961 字节
            row_number = data[0]  # 第一个字节为行号
            pixel_data = data[1:]  # 从第2字节开始是像素数据
            
            # 解析每个像素的RGB
            for i in range(0, len(pixel_data), 4):  # 每个像素用4字节
                col = i // 4
                if col < 240 and row_number < 160:
                    blue = pixel_data[i]
                    green = pixel_data[i + 1]
                    red = pixel_data[i + 2]
                    # 第四个字节为保留字节，可以忽略
                    self.image_data[row_number, col] = [red, green, blue]

            # print(row_number)
            
            # 如果已收到所有行，则更新图像显示
            # if row_number == 159:
            self.update_display()

                   # 更新文本显示内容
            if row_number == 159:
                current_time = QDateTime.currentDateTime().toString("yyyy-MM-dd HH:mm:ss")
                existing_text = self.text_display.text()
                new_text = f"荣誉截屏完成！{current_time}\n{existing_text}"
                self.text_display.setText(new_text)
            # if row_number == 68:
            # self.update_display()
        
        except BlockingIOError:
            pass  # 没有数据时继续等待

app = QApplication(sys.argv)
window = MainWindow()
window.show()
app.exec_()

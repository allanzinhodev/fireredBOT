import cv2
import numpy as np
import time
import mss

template = cv2.imread("pokeball.png")
if template is None:
    print("❌ Erro: 'pokeball.png' não encontrada na pasta.")
    exit()

template_gray = cv2.cvtColor(template, cv2.COLOR_BGR2GRAY)

print("🔄 Verificando a tela a cada 5 segundos (Ctrl+C para parar)...")

with mss.mss() as sct:
    try:
        while True:
            screenshot = np.array(sct.grab(sct.monitors[1]))
            gray_screen = cv2.cvtColor(screenshot, cv2.COLOR_BGRA2GRAY)

            result = cv2.matchTemplate(gray_screen, template_gray, cv2.TM_CCOEFF_NORMED)
            threshold = 0.9
            loc = np.where(result >= threshold)

            if len(loc[0]) > 0:
                print("✅ captured")
                with open("captured.txt", "w") as f:
                    f.write("captured")
            else:
                print("❌ not captured")
                with open("captured.txt", "w") as f:
                    f.write("not captured")

            time.sleep(5)

    except KeyboardInterrupt:
        print("\n⛔ Encerrado.")

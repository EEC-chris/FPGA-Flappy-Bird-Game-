# Flappy Bird Game on FPGA (Verilog HDL)

This is the final project for the "Digital System Design Lab" course at National Taiwan University of Science and Technology (NTUST).

## 專案描述 (Project Description)

本專案旨在以純Verilog硬體描述語言，於FPGA開發板上重現經典遊戲「Flappy Bird」。整個遊戲的邏輯，包括小鳥的重力與跳躍物理、水管的移動與隨機生成、碰撞偵測以及分數計算，皆由硬體狀態機(FSM)實現。

This project aims to recreate the classic "Flappy Bird" game on an FPGA board using purely Verilog HDL. All game logic, including the bird's physics (gravity and jump), pipe movement with pseudo-random generation, collision detection, and score-keeping, is implemented through a hardware Finite State Machine (FSM).

## 主要特色 (Key Features)

* **狀態機設計 (FSM Design)**: 使用ASM Chart規劃遊戲的核心流程，包括開始、遊戲中、跳躍與死亡等狀態。
* **偽隨機生成器 (Pseudo-Random Generator)**: 設計了一個簡易的隨機生成器，用於改變水管缺口的高度，增加遊戲的挑戰性。
* **即時碰撞偵測 (Real-time Collision Detection)**: 在每個時脈週期(Clock Cycle)精準判斷小鳥與水管及邊界的碰撞。
* **七段顯示器計分 (7-Segment Display Scoring)**: 將遊戲分數即時顯示於板端的七段顯示器上。

## 設計與驗證工具 (Tools Used)

* **設計語言**: Verilog HDL
* **模擬軟體**: ModelSim
* **開發板**: [請填寫你使用的FPGA開發板型號，例如 Altera DE2-115]

## 專案檔案結構 (File Structure)

* `/rtl`: 包含所有Verilog設計原始碼。
* `/sim`: 包含用於功能驗證的Testbench檔案。
* `/doc`: 存放本專案的簡報檔案。

## 遊戲展示 (Demo)

[如果你有錄製影片，強烈建議上傳至YouTube並在此附上連結，這會非常加分！]

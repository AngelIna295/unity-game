using TMPro;
using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PC : MonoBehaviour, IInteractable
{
    public GameObject UI_PC;
    public static bool isActive = false;
    public CharacterController freezeMove;
    public Camera freezeCamera;

    public TextMeshProUGUI energyText;
    public Energie energieSource;

    public TextMeshProUGUI monsterSleepText;
    public SleepingMonster sleepingMonster;

    public List<Light> lightsToFlicker;           // ← список источников света
    public float flickerInterval = 0.1f;          // интервал мигания
    public float flickerDuration = 3f;            // сколько длится мигание

    public float sleepZeroDuration = 5f;
    public static float sleepState = 100f; // Состояние сна монстра, 100% - полностью спит, 0% - не спит

    public static float energy = 100;
    public static float sleepPercent = 100;
    public static bool isWakeUped = false;

    public Btn_door doorControl;
    public Btn_door2 doorControl2;

    public Animator anim_LiteFlick;
    public Animator anim_LiteFlick2;
    public Animator anim_LiteFlick3;
    public Animator anim_LiteFlick4;

    //
    private static bool glitchTriggered = false;

    void Start()
    {
        UI_PC.SetActive(false);
    }

    public void Interact()
    {
        if (!isActive)
        {
            UI_PC.SetActive(true);
            freezeCamera.enabled = true;
            freezeMove.enabled = true;
            Cursor.visible = false;
            Cursor.lockState = CursorLockMode.Locked;
            isActive = true;
        }
        else
        {
            UI_PC.SetActive(false);
            freezeCamera.enabled = true;
            freezeMove.enabled = true;
            Cursor.visible = false;
            Cursor.lockState = CursorLockMode.Locked;
            isActive = false;
        }
    }
    void Update()
    {
        // Обновление сна гуманоида
        if (sleepPercent > 0f)
        {
            sleepPercent -= 1f * Time.deltaTime;
            sleepPercent = Mathf.Max(0f, sleepPercent);
        }

        // Если гуманоид "не спит", энергия уходит быстрее
        if (sleepPercent <= 0f)
        {
            energy -= 1f * Time.deltaTime; // Быстрая потеря энергии
            anim_LiteFlick.SetBool("isActive", true);
            anim_LiteFlick2.SetBool("isActive", true);
            anim_LiteFlick3.SetBool("isActive", true);
            anim_LiteFlick4.SetBool("isActive", true);
        }
        else
        {
            // Обычное падение энергии, если гуманоид спит
            if (energy > 0f)
            {
                energy -= 0.1f * Time.deltaTime;
            }
        }

        // Защита от отрицательных значений
        energy = Mathf.Max(0f, energy);

        // Если энергия достигла 0 и двери ещё не открыты, открыть их
        if (energy <= 0f && !Btn_door.isOpen)
        {
            doorControl.OpenCLose();
        }

        // Если энергия достигла 0 и двери ещё не открыты, открыть их
        if (energy <= 0f && !Btn_door2.isOpen)
        {
            doorControl2.OpenCLose();
        }


        // Отображение значений
        energyText.text = "Energy: " + Mathf.RoundToInt(energy) + "%";
        monsterSleepText.text = "Humanoid: " + Mathf.RoundToInt(sleepPercent) + "%";

        // Обработка пробуждения
        if (sleepState <= 0f)
        {
            sleepState = 0f;
            isWakeUped = true;
        }

        if (sleepPercent <= 0f && !glitchTriggered)
        {
            glitchTriggered = true;

            // Запустить сбой камер
            Camera_System[] cameras = FindObjectsOfType<Camera_System>();
            foreach (Camera_System cam in cameras)
            {
                cam.TriggerGlitch();
            }
        }
    }
}
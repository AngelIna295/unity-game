using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SleepingMonster : MonoBehaviour, IInteractable
{
    public static bool isActive = false;

    public void Interact() 
    {
        if(injector.isTaken == true)
        {
            if (PC.sleepPercent > 0)
            {
                // isActive = false;
                PC.sleepPercent = 100f; // Устанавливаем состояние сна монстра на 100%
            }
            else
            {
                // isActive = true;
                PC.sleepPercent = 0f; // Устанавливаем состояние сна монстра на 0%
            }
        }
    }
}

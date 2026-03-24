using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DropInject : MonoBehaviour, IInteractable
{
    public injector injector;

    public void Interact()
    {
        if (injector.isTaken == true)
        {
            injector.Drop();
        }
    }
}

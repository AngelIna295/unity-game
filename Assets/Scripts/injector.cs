using UnityEngine;

public class injector : MonoBehaviour, IInteractable
{
    public PC pc;                          // ПК, который показывает сон
    public Transform handPoint;            // Точка, куда прикрепляем шприц
    public float pickupRange = 3f;         // Дистанция, с которой можно взаимодействовать
    public Transform playerViewPoint;      // Камера или объект взгляда

    private bool isHeld = false;
    private Vector3 savedPosition;
    private Quaternion savedRotation;

    private bool isLookedAt = false;

    public static bool isTaken = false; // Флаг, чтобы не брать шприц, если он уже взят

    void Update()
    {
        // Поднятие / опускание шприца
        if (Input.GetKeyDown(KeyCode.R))
        {
            if (!isHeld && isLookedAt)
            {
                Pickup();
            }
            else if (isHeld)
            {
                Drop();
            }
        }
    }

    public void Interact()
    {
        if (isTaken == false)
        {
            Pickup();
        }
        else
        {
            Drop();
        }
    }
    void Pickup()
    {
        isTaken = true;
        savedPosition = transform.position;
        savedRotation = transform.rotation;

        transform.position = handPoint.position;
        transform.rotation = handPoint.rotation;
        transform.SetParent(handPoint);

        isHeld = true;
    }

    public void Drop()
    {
        isTaken = false;
        transform.SetParent(null);
        transform.position = savedPosition;
        transform.rotation = savedRotation;

        isHeld = false;
    }
}


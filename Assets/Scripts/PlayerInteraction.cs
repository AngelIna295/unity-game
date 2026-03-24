using UnityEngine;

public class PlayerInteraction : MonoBehaviour
{
    public Camera mainCam;
    public float interactionDistance = 20f;
    public GameObject interactionUI;

    void Update()
    {
        InteractionRay();
    }
    void InteractionRay()
    {
        Ray ray = new Ray(mainCam.transform.position, mainCam.transform.TransformDirection(Vector3.forward));
        RaycastHit hit;
        bool hitSomething = false;

        if (Physics.Raycast(ray, out hit, interactionDistance))
        {
            IInteractable interactable = hit.collider.GetComponent<IInteractable>();

            if (interactable != null)
            {
                hitSomething = true;

                if (Input.GetKeyDown(KeyCode.E))
                {
                    interactable.Interact();
                }
            }
        }
        interactionUI.SetActive(hitSomething);
    }
}

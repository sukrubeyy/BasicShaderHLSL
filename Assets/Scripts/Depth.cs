using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Depth : MonoBehaviour
{
    /// <summary>
    /// This function is called when the object becomes enabled and active.
    /// </summary>
    void OnEnable()
    {
        
        GetComponent<Camera>().depthTextureMode=DepthTextureMode.DepthNormals;
    }
}

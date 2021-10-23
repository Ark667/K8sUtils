
<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://github.com/Ark667/K8sUtils">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

<h1 align="center">K8sUtils</h1>

  <p align="center">
    Docker image to keep Kubernetes regular tools version up to date without installing local.
    <br />
    <a href="https://github.com/Ark667/K8sUtils"><strong>Explore the docs »</strong></a>
    <br />    
    <a href="https://github.com/Ark667/K8sUtils/issues">Report Bug</a>
    ·
    <a href="https://github.com/Ark667/K8sUtils/issues">Request Feature</a>
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <!-- <li><a href="#roadmap">Roadmap</a></li> -->
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

This project was intended to keep containerized and updated versions of some regular Kubernetes tools. 

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/I2I16OYC5)

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [Docker](https://www.docker.com/)
* [Ubuntu](https://ubuntu.com/)
* [Kubectl](https://github.com/kubernetes/kubectl)
* [Kops](https://github.com/kubernetes/kops)
* [Linkerd](https://github.com/linkerd/linkerd2)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

You can execute current release with Docker.

```pws
docker run --rm -it -v "$env:USERPROFILE\.kube:/root/.kube" ghcr.io/ark667/k8sutils:master bash
```

You can also clone the repo and build the image yourself.

```pws
git clone https://github.com/Ark667/K8sUtils.git
Docker build -t k8sutils .\K8sUtils
```


<p align="right">(<a href="#top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage

Basic usage is pretty straightforrward. Just run the container with desired tool and parameters. The mapped volume contains Kubectl context configuration so
the container tools can also use it.

```pws
docker run --rm -it -v "$env:USERPROFILE\.kube:/root/.kube" k8sutils bash
```

```pws
docker run --rm -it -v "$env:USERPROFILE\.kube:/root/.kube" k8sutils kubectl get pods -n kube-system
```

```pws
docker run --rm -it -v "$env:USERPROFILE\.kube:/root/.kube" k8sutils echo `nKUBECT`n========; kubectl version; echo `nKOPS`n========; kops version; echo `nLINKERD`n========; linkerd version; echo ''
```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Aingeru Medrano - [@AingeruBlack](https://twitter.com/AingeruBlack) <!-- - email@email_client.com -->

Project Link: [https://github.com/Ark667/K8sUtils](https://github.com/Ark667/K8sUtils)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [https://github.com/Gallore/yaml_cli](https://github.com/Gallore/yaml_cli)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Ark667/K8sUtils.svg?style=for-the-badge
[contributors-url]: https://github.com/Ark667/K8sUtils/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Ark667/K8sUtils.svg?style=for-the-badge
[forks-url]: https://github.com/Ark667/K8sUtils/network/members
[stars-shield]: https://img.shields.io/github/stars/Ark667/K8sUtils.svg?style=for-the-badge
[stars-url]: https://github.com/Ark667/K8sUtils/stargazers
[issues-shield]: https://img.shields.io/github/issues/Ark667/K8sUtils.svg?style=for-the-badge
[issues-url]: https://github.com/Ark667/K8sUtils/issues
[license-shield]: https://img.shields.io/github/license/Ark667/K8sUtils.svg?style=for-the-badge
[license-url]: https://github.com/Ark667/K8sUtils/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/aingeru/
[product-screenshot]: images/screenshot.png

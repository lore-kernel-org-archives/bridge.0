Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7w7+tvnW1G+Cle3enHiPY2ZUGZs43aoQoOoR2xnTfDk=;
 b=qQBpX7EqHscfN/xttnOIq269jQJMhj2p5YKvSz2dLaR5FXlmfk12gczTp3DWFoO/qt
 7tcvyb3ikdBmtwLr802xJ1ToVZPpjfy904wMElH3hQzVccak/k+9zFg0wCTJjZddGDbB
 xaxkaogbPyLlh+OYjSwI4qwbzT3D9RkeKgrgC8yAmOOvLHphBHx93fBP1iK47HYk2C4Y
 sxipObGsP3wAE8aM/O44cj8+qn1SGc48Q7r8X79oDvMR+zpvZ3hs7eHEkMlPW1WgZ+lp
 FLZKWhg1+o4pMBIrH5DcZApKoxeWvWDNHxXe05FvKLWr7q07292BhPKSC9M6xOtYYb6+
 wgDA==
Date: Fri, 4 Sep 2020 15:44:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200904154406.4fe55b9d@hermes.lan>
In-Reply-To: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH RFC 0/7] net: bridge: cfm: Add support for
 Connectivity Fault Management(CFM)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Fri, 4 Sep 2020 09:15:20 +0000
Henrik Bjoernlund <henrik.bjoernlund@microchip.com> wrote:

> Connectivity Fault Management (CFM) is defined in 802.1Q section 12.14.
>=20
> Connectivity Fault Management (CFM) comprises capabilities for
> detecting, verifying, and isolating connectivity failures in
> Virtual Bridged Networks. These capabilities can be used in
> networks operated by multiple independent organizations, each
> with restricted management access to each other=E2=80=99s equipment.
>=20
> CFM functions are partitioned as follows:
>     =E2=80=94 Path discovery
>     =E2=80=94 Fault detection
>     =E2=80=94 Fault verification and isolation
>     =E2=80=94 Fault notification
>     =E2=80=94 Fault recovery
>=20
> The primary CFM protocol shims are called Maintenance Points (MPs).
> A MP can be either a MEP or a MHF.
> The MEP:
>     -It is the Maintenance association End Point
>      described in 802.1Q section 19.2.
>     -It is created on a specific level (1-7) and is assuring
>      that no CFM frames are passing through this MEP on lower levels.
>     -It initiates and terminates/validates CFM frames on its level.
>     -It can only exist on a port that is related to a bridge.
> The MHF:
>     -It is the Maintenance Domain Intermediate Point
>      (MIP) Half Function (MHF) described in 802.1Q section 19.3.
>     -It is created on a specific level (1-7).
>     -It is extracting/injecting certain CFM frame on this level.
>     -It can only exist on a port that is related to a bridge.
>     -Currently not supported.
>=20
> There are defined the following CFM protocol functions:
>     -Continuity Check
>     -Loopback. Currently not supported.
>     -Linktrace. Currently not supported.
>=20
> This CFM component supports create/delete of MEP instances and
> configuration of the different CFM protocols. Also status information
> can be fetched and delivered through notification due to defect status
> change.
>=20
> The user interacts with CFM using the 'cfm' user space client program, the
> client talks with the kernel using netlink. The kernel will try to offload
> the requests to the HW via switchdev API (not implemented yet).
>=20
> Any notification emitted by CFM from the kernel can be monitored in user
> space by starting 'cfm_server' program.
>=20
> Currently this 'cfm' and 'cfm_server' programs are standalone placed in a
> cfm repository https://github.com/microchip-ung/cfm but it is considered
> to integrate this into 'iproute2'.
>=20
> Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>

Could this be done in userspace? It is a control plane protocol.
Could it be done by using eBPF?

Adding more code in bridge impacts a large number of users of Linux distros.
It creates bloat and potential security vulnerabilities.

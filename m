Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640278785;
 bh=QPwau80pk3UraYb+vqoVcwXOj+oK0+cKYssBIEF/HoM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=H3py8MAESqwKAXYzesMo4Dyke0NuI8jwgvdGoDpJNVLAXQjgp4zAu48A1LZMywN/3
 obU1dv28auI53r7Zp18vCzsmvxpZ4WIfBju18KthXDrdmNDuz+x7EpqyPlGdakhVRs
 zBSi2UCQBsfcOsRHSqXDX7UjyY+HWHt9+Z3qtzY1YBEaOPOAvjvGyhKI4kfSTR3I0h
 ufalNYdcLXXM8ka8+Y2VGLP37soqBPxpTkIcRgDIDAvreNgtIy2iPnbZL6vHUqBXzo
 T96H43Kfr0RlT3DznY++BW/t9q/YbyxIZ3ffplyFUpmudFIWkMZk1KeuAGDxpKo81J
 D4+v3pOIvyu4A==
Date: Thu, 23 Dec 2021 08:59:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20211223085944.55b43857@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20211223153139.7661-3-repk@triplefau.lt>
References: <20211223153139.7661-1-repk@triplefau.lt>
 <20211223153139.7661-3-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 2/2] net: bridge: Get SIOCGIFBR/SIOCSIFBR
 ioctl working in compat mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On Thu, 23 Dec 2021 16:31:39 +0100 Remi Pommarel wrote:
> In compat mode SIOC{G,S}IFBR ioctls were only supporting
> BRCTL_GET_VERSION returning an artificially version to spur userland
> tool to use SIOCDEVPRIVATE instead. But some userland tools ignore that
> and use SIOC{G,S}IFBR unconditionally as seen with busybox's brctl.
> 
> Example of non working 32-bit brctl with CONFIG_COMPAT=y:
> $ brctl show
> brctl: SIOCGIFBR: Invalid argument
> 
> Example of fixed 32-bit brctl with CONFIG_COMPAT=y:
> $ brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Since Arnd said this is not supposed to be backported I presume it
should go to net-next?

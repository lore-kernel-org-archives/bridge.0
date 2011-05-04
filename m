Date: Wed, 4 May 2011 10:32:19 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110504103219.56753a20@nehalam>
In-Reply-To: <BANLkTi=xF2j-hU+4mELWWpXet06WV5NAxA@mail.gmail.com>
References: <BANLkTi=xF2j-hU+4mELWWpXet06WV5NAxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge and authentication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: IMS <ims77.dev@gmail.com>
Cc: bridge@linux-foundation.org

On Wed, 4 May 2011 15:21:41 +0200
IMS <ims77.dev@gmail.com> wrote:

> Hello,
> I'm trying to configure an Ubuntu server with 2 wired interfaces set as a
> bridge and I want a radius authentication on each interfaces.
> 
> I'm able to set my configuration files to have a bridge between the 2
> interfaces without authentication.
> I'm able to set my configuration files to have an authentication on each
> interfaces but without the bridge.
> I don't know how to configure my files to have both authentication and
> bridge !
> Can someone help me ?
> 
> I give you my /etc/network/interface not working :
> *# loopback interface**
> auto lo**
> iface lo inet loopback**
> # network interface**
> auto eth0**
> iface eth0 inet manual**
> **
> auto eth1**
> iface eth1 inet manual**
> **
> auto br0**
> iface br0 inet dhcp**
> bridge_ports eth0 eth1**
> **
> wpa-iface eth0  #*How to add eth1 ? If I add a new line it's not working
> *wpa-bridge br0**
> wpa-driver wired**
> wpa-conf /etc/wpa_supplicant/wired.conf*
> 
> 
> The wired.conf file for information :
> *ctrl_interface=/var/run/wpa_supplicant**
> ctrl_interface_group=0**
> ap_scan=0**
> #On configure la re-authentification rapide pour protocoles EAP**
> #fast_reauth=1**
> **
> network={**
>         ssid="lan"**
>         key_mgmt=IEEE8021X**
>         eapol_flags=0**
>         eap=MD5**
>         identity="labo"**
>         password="test"**
> }*
> 
> With this configuration, it's working if my interface eth0 is connected, but
> it's not working if it's eth1 which is connected.
> Could you tell me what I need to add in my configuration file ?
> 
> Thanks for your help.
> 
> Sebastien.

Once you put interfaces into a bridge, all applications and services
should use the bridge interface not the underlying ethernet devices
because packets received on the underlying device will be absorbed
by the bridge and not processed for the ethernet device.



-- 

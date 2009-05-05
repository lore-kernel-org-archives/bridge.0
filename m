Message-ID: <49FFD355.70301@free.fr>
Date: Tue, 05 May 2009 07:49:09 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us> <49F8C4C3.9020504@gmail.com>	
	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>	
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>	
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>	
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>	
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<2e59e6970905041633u57678f2dn4e433ec417475927@mail.gmail.com>
In-Reply-To: <2e59e6970905041633u57678f2dn4e433ec417475927@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

richardvoigt@gmail.com wrote:
> 
> On Mon, May 4, 2009 at 4:06 PM, Jochen Hebbrecht 
> <jochenhebbrecht@gmail.com <mailto:jochenhebbrecht@gmail.com>> wrote:
> 
>     I changed the configuration and restarted the networking daemon. I'm
>     getting this output
> 
>     jochus@Bacardi ~ $ sudo /etc/init.d/networking restart
>      * Reconfiguring network
>     interfaces...
>     ioctl[SIOCGIFINDEX]: No such device
>     Failed to open l2_packet connection for the bridge interface 'br0'
>     wpa_supplicant: /sbin/wpa_supplicant daemon failed to start
>     run-parts: /etc/network/if-pre-up.d/wpasupplicant exited with return
>     code 1
> 
>     Waiting for br0 to get ready (MAXWAIT is 32 seconds).
> 
> 
> Surely things are getting run in the wrong order.
> 
> First, the bridge should be created.
> Then, the interfaces should be configured, joined to the bridge, and 
> brought up.
> Then wpa_supplicant should run.
> After wpa_supplicant associates to the wireless access point, then dhcp 
> should succeed.
> 
> It seems like ubuntu's network scripts don't create the bridge until too 
> late.

I agree with Richard.

Jochen, can you please try the following configuration (step #5 in my 
previous e-mail) ?

#auto eth0
iface eth0 inet manual

#auto eth1
iface eth1 inet manual

auto br0
iface br0 inet dhcp
bridge_ports eth0 eth1
# the wpa-iface option is expected to instruct wpa_supplicant
# to setup the wifi link using eth1 instead of br0.
wpa-iface eth1
wpa-driver wext
wpa-ssid ##SSID##
wpa-ap-scan 1
wpa-proto RSN
wpa-pairwise CCMP
wpa-group CCMP
wpa-key-mgmt WPA-PSK
wpa-psk ##PSK KEY##
# The wpa-bridge option is expected to instruct wpa_supplicant
# to listen on br0 instead of eth1.
wpa-bridge br0

And if this fail, please try the same configuration, without the 
wpa-bridge option.

If both fail, please provide the list of files in /etc/network/if*/*.

	Nicolas.

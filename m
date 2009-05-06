Message-ID: <4A01EDEA.8040106@free.fr>
Date: Wed, 06 May 2009 22:07:06 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr> <4A007103.4010501@gmail.com>
	<4A00B327.6080705@free.fr> <4A01BF38.4080704@gmail.com>
In-Reply-To: <4A01BF38.4080704@gmail.com>
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

Jochen Hebbrecht a wrote:

 > I think you mean bridge_hw (with an underscore instead of a dash?). I
 > can't find any information about bridge-hw in the man pages.

bridge-hw and bridge_hw is exactly the same. (No difference between 
underscore and dash). Both will set a variable $IF_BRIDGE_HW, to be used 
by the scripts in /etc/network/if-*.d/*.

 From interfaces(5) : "Additionally, all options given in an interface 
definition stanza are exported to the environment in upper case with 
"IF_" prepended and with hyphens converted to underscores and 
non-alphanumeric characters discarded."

>> Can you try to use the bridge-hw option of /etc/network/interfaces, to 
>> force the bridge MAC address to the MAC address of the wireless 
>> interface ? This might solve the communication problem for UBUNTU 
>> SERVER... but unfortunately probably not for the bridging function.
>>
> Now the bridge comes up perfectly, and ubuntu server can ping the 
> internet. But nobody on the eth0 of ubuntu server can access the network 
> :-( ... so no bridging indeed

This is unfortunately what I expected.

Now, you can have a last try with your current bridge configuration, by 
upgrading the firmware of your router, ensuring WDS is enabled in the 
router, and hope that the driver of your wifi adapter support WDS... By 
the way, what is the type of your wifi adapter ?

If that fail, I think we have two options :

- Try to setup a very special bridge configuration, with some sort of 
masquerading of the MAC address. This would require at least to use 
ebtables to replace the source MAC address in the header (and in the 
payload for ARP) of packets sent on the wifi interface, to route packets 
in the server, to stop the server from sending ICMP redirect in the wifi 
interface and to setup a proxy_dhcp on the server. It would be hard to 
setup, hard to debug and impossible to maintain... Probably not a good 
idea... Funny to try, but not a good target.

- Setup a simple router configuration on the server, using another 
private subnet on location B. Using a simple NAT/Masquerading 
configuration (with iptables), it could be possible to hide the subnet 
of location B from location A, but still allow access to the printer of 
location B from location A and access to location A and to Internet from 
location B. If you don't have a really good reason to stick to bridge 
(like using a non-IP protocol), I suggest you try this.

	Nicolas.

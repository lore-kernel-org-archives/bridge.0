MIME-Version: 1.0
In-Reply-To: <4A056646.5050909@gmail.com>
References: <20090428124009.GA26387@kallisti.us> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr> <4A007103.4010501@gmail.com>
	<4A00B327.6080705@free.fr> <4A01BF38.4080704@gmail.com>
	<4A01EDEA.8040106@free.fr> <4A056646.5050909@gmail.com>
Date: Sat, 9 May 2009 18:30:39 -0500
Message-ID: <2e59e6970905091630wc843397h9102ee22654dc550@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

On Sat, May 9, 2009 at 6:17 AM, Jochen Hebbrecht
<jochenhebbrecht@gmail.com> wrote:
> Nicolas de Peslo=FCan schreef:
>> bridge-hw and bridge_hw is exactly the same. (No difference between
>> underscore and dash). Both will set a variable $IF_BRIDGE_HW, to be
>> used by the scripts in /etc/network/if-*.d/*.
>>
>> From interfaces(5) : "Additionally, all options given in an interface
>> definition stanza are exported to the environment in upper case with
>> "IF_" prepended and with hyphens converted to underscores and
>> non-alphanumeric characters discarded."
> Ah, ok, thnx!
>>
>> This is unfortunately what I expected.
>>
>> Now, you can have a last try with your current bridge configuration,
>> by upgrading the firmware of your router, ensuring WDS is enabled in
>> the router, and hope that the driver of your wifi adapter support
>> WDS... By the way, what is the type of your wifi adapter ?
> I had a "chat" with somebody of the support site of Linksys. The WRT54GS
> enables WDS. So we can say this is my problem. My wifi adapter is a WMP54=
G
>>
>> If that fail, I think we have two options :
>>
>> - Try to setup a very special bridge configuration, with some sort of
>> masquerading of the MAC address. This would require at least to use
>> ebtables to replace the source MAC address in the header (and in the
>> payload for ARP) of packets sent on the wifi interface, to route
>> packets in the server, to stop the server from sending ICMP redirect
>> in the wifi interface and to setup a proxy_dhcp on the server. It
>> would be hard to setup, hard to debug and impossible to maintain...
>> Probably not a good idea... Funny to try, but not a good target.
> This really sounds like Chinese in my ears :-D

http://en.wikipedia.org/wiki/Proxy_ARP

http://lists.netfilter.org/pipermail/netfilter/2007-May/068615.html

>>
>> - Setup a simple router configuration on the server, using another
>> private subnet on location B. Using a simple NAT/Masquerading
>> configuration (with iptables), it could be possible to hide the subnet
>> of location B from location A, but still allow access to the printer
>> of location B from location A and access to location A and to Internet
>> from location B. If you don't have a really good reason to stick to
>> bridge (like using a non-IP protocol), I suggest you try this.
> I was thinking on this situation too. But how will be somebody in subnet
> A able to reach someone of subnet B? We are gonna have to change the
> routing tables on the client side too?
>
> Jochen
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

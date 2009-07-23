Message-ID: <4A68171F.5020409@ipfire.org>
Date: Thu, 23 Jul 2009 09:54:07 +0200
From: Michael Tremer <michael.tremer@ipfire.org>
MIME-Version: 1.0
References: <4A6638A5.208@ipfire.org> <4A668C49.7080209@superduper.net>
	<4A66C14C.4090300@ipfire.org> <4A677703.4060507@free.fr>
	<4A677ACA.3060100@ipfire.org> <4A678123.1020006@free.fr>
In-Reply-To: <4A678123.1020006@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

Nicolas de Peslo=FCan wrote:
> Michael Tremer wrote:
>> Oops, just sent the email when your one scrabbled to my inbox.
>>
>> https://lists.linux-foundation.org/pipermail/bridge/2009-July/006626.htm=
l=20
>>
>>
>> I applied that ebtables rule to the chain but no packages got to the=20
>> vlan interface (eth0.30) anymore.
>>
>> Michael
>
> For as far as I remember, this hack works really well when eth0 and=20
> eth0.30 are not in the same bridge (br0/br1). Anyway, I cannot think=20
> of a good reason for it not to work in a single bridge.
Well, it actually does not. But there is a very interesting thing: The=20
eth0.30 gets all packages (esp. ARP and my ICMP reply for testing) but=20
the ping command on the other shell returns *nothing*.
iptables has no rules got and policy is ACCEPT.

brctl addbr br0
brctl addbr br1

brctl addif br0 eth0
brctl addif br1 eth0.30

ebtables -t broute -D BROUTING -p 802_1Q -i eth0 -j DROP is the command.

Do you have got any ideas how to debug this?
>
> Try and dig around with ebtable, using the logging feature. Im' pretty=20
> sure it works, but does not have a bridge available here to test.
>
> I googled around to try and find the original web page where a learned=20
> this hack, but without any success. You can try, searching for=20
> ebtables+BROUTING+DROP+802_1Q+vlan-id and so on...
>
>     Nicolas.
Sincerely,

Michael


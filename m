MIME-Version: 1.0
In-Reply-To: <2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
References: <20090428124009.GA26387@kallisti.us>
	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>
	<49F77248.1050800@gmail.com>
	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>
	<49F87D4E.4060705@gmail.com> <20090429162651.GA9455@kallisti.us>
	<49F882F9.4010100@gmail.com> <20090429165329.GA9893@kallisti.us>
	<49F8C4C3.9020504@gmail.com>
	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
Date: Thu, 30 Apr 2009 08:30:31 +0200
Message-ID: <db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

2009/4/30 richardvoigt@gmail.com <richardvoigt@gmail.com>:
>
>
> On Wed, Apr 29, 2009 at 9:21 PM, Jochen Hebbrecht
> <jochenhebbrecht@gmail.com> wrote:
>>
>> Ross Vandegrift schreef:
>>
>> On Wed, Apr 29, 2009 at 06:40:25PM +0200, Jochen Hebbrecht wrote:
>>
>>
>> Yes, it is plugged in ( Ubuntu says: link is ready ).
>> I also tried statically, but no improvements :-( ...
>>
>>
>> Is your wireless access point also bridging between the wired and the
>> wireless?  If so, then you have two bridges circulating packets
>> between the wired and wireless networks.
>>
>>
>> What do you mean with "wireless access point"? My eth1? I think the brid=
ge
>> is ok. In one of my previous mails, you see the sniffer logging DHCP
>> discovers on eth0 AND eth1
>
> That's at the IP stack.=A0 At the firmware level, most wireless cards wil=
l
> refuse to transmit/receive packets with other MAC addresses, making them
> useless for AP or bridging.=A0 Yours is apparently not one of those since
> bridging works in Windows (or else the Windows bridge code does transpare=
nt
> routing w/MAC address replacement, rather like NAT or PAT but working at
> layer 2 instead of 3).
>
> That's why I suggested testing for the DHCP discover on a different wirel=
ess
> node.

Hmm, can you explain to me how I can try to use a different wireless node?

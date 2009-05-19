MIME-Version: 1.0
In-Reply-To: <4A1296ED.3030801@epfl.ch>
References: <4A11714A.2000301@epfl.ch>
	<2e59e6970905181635h3a4da749ue75574633ff75f5e@mail.gmail.com>
	<4A1296ED.3030801@epfl.ch>
Date: Tue, 19 May 2009 14:45:56 -0500
Message-ID: <2e59e6970905191245y41a7a367offd84b35b652c947@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] network bridging between wireless and wired connection
	fails Cont'd
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexandre Becholey <alexandre.becholey@epfl.ch>
Cc: "bridge@osdl.org" <bridge@osdl.org>

On Tue, May 19, 2009 at 6:24 AM, Alexandre Becholey
<alexandre.becholey@epfl.ch> wrote:
> Hi thanks for your reply.
>
> # brctl showmacs br0
> port no =A0 =A0mac addr =A0 =A0 =A0 =A0is local? =A0 =A0ageing timer
> =A02 =A0 =A000:14:2d:21:99:2a =A0 =A0no =A0 =A0 =A0 =A0 =A0 0.78 =A0 =A0 =
=A0 =A0 =A0 =A0 (<- PC1's mac)
> =A01 =A0 =A000:1b:38:e8:51:1c =A0 =A0no =A0 =A0 =A0 =A0 =A0 5.75 =A0 =A0 =
=A0 =A0 =A0 =A0 (<- PC2's mac)
> =A01 =A0 =A000:21:e9:e7:ae:88 =A0 =A0yes =A0 =A0 =A0 =A0 =A0 0.00 =A0 =A0=
 =A0 =A0 =A0 =A0(<- wlan0)
> =A02 =A0 =A000:22:41:30:92:18 =A0 =A0yes =A0 =A0 =A0 =A0 =A0 0.00 =A0 =A0=
 =A0 =A0 =A0 =A0(<- eth1)
>
> ifconfig shows that br0 has wlan0's mac address. If a use another wireles=
s
> interface with a "higher" mac address, br0 has eth1's mac address
>
> No iptables nor ebtables running.
>
> Alexandre

Does your access point do any sort of filtering (like MAC-based table
of authorized users)?  Perhaps PC1 is not listed as authorized and so
the AP won't forward his traffic when it receives it from the wireless
side (repeated through the Linux bridge).

The linux bridge is a wireless client, not an access point, right?

>
>
> richardvoigt@gmail.com wrote:
>>
>> What is the output of "brctl br0 showmacs" ?
>>
>> Are you running iptables or ebtables?
>

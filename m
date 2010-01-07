MIME-Version: 1.0
In-Reply-To: <8cad0aa1001040649l19eff53wd8cf7cfadc177f0a@mail.gmail.com>
References: <8cad0aa1001040627l48c22f11id1c48c6cfaac3585@mail.gmail.com>
	<4B41FEE9.9020900@gmail.com>
	<8cad0aa1001040649l19eff53wd8cf7cfadc177f0a@mail.gmail.com>
Date: Thu, 7 Jan 2010 11:16:46 +0100
Message-ID: <8cad0aa1001070216h3f3f0d94s90c2756f3c65b83c@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ulog : recvfrom no space available => how do I
	calculate a good value ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Saikiran Madugula <hummerbliss@gmail.com>
Cc: bridge@lists.linux-foundation.org

Hi everyone !

2010/1/4 Jean-Michel Hautbois <jhautbois@gmail.com>:
> 2010/1/4 Saikiran Madugula <hummerbliss@gmail.com>:
>> Jean-Michel Hautbois wrote:
>>> Hi there !
>>>
>>> I keep trying to use the ulog/netlink system to receive only the
>>> packets I'm interested by and bridging everything else...
>>> I have a problem using this, because of a too small buffer ?
>>>
>>> I am using the recvfrom as the example given on the website, and I am
>>> getting a "no space buffer available" when I have packets =A0about
>>> 2Mbits/sec...
>> Probably the netlink receive buffer is being overrun, try increasing the=
 netlink
>> receive buffer size (see ipulog_create_handle() being called in
>> libipulog/ulog_test.c for example).
>
> I have a buffer length of 65536 for the socket... It already seems
> high for such a low bandwidth...
> Or am I misunderstanding something ?

I have changed the values in net.core.rmem_max and
net.core.rmem_default to 2097152.
It seems to be better, but when I increase the bandwidth, I have this
error "no buffer space avalaible" again...

Is there any way to have a high performance capture with ebtables+ulog ?
Something like zero-copy mechanism for example...

Thanks in advance !
Best Regards.
JM

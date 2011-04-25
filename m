Message-ID: <4DB5BE51.6050108@gmail.com>
Date: Mon, 25 Apr 2011 20:32:49 +0200
From: =?ISO-8859-2?Q?Ireneusz_Szcze=B6niak?= <irek.szczesniak@gmail.com>
MIME-Version: 1.0
References: <4DB540CA.8030903@gmail.com>
	<BANLkTimgVfBmKyE8YcO4_TuQvCf_Y-vfNQ@mail.gmail.com>
In-Reply-To: <BANLkTimgVfBmKyE8YcO4_TuQvCf_Y-vfNQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] mind-boggling questions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Thanks, Sasikanth, for your response.  Yes, I didn't realize that we=20
need a MAC address for STP.  Not only we need a MAC for a bridge, but=20
there can be MAC addresses for ports too, and why I just don't know.=20
I need to do some reading on STP, because I know very little about it.

On 25.04.2011 13:02, Sasikanth V wrote:
> 2011/4/25 Ireneusz Szcze=B6niak <irek.szczesniak@gmail.com
> <mailto:irek.szczesniak@gmail.com>>
>
>     Hi,
>
>     I have a few questions on the Linux bridge, and I would appreciate it
>     if someone could answer them.
>
>     1. Why does a bridge have a MAC address?  A bridge doesn't need a MAC
>     address. I understand that a Linux box might offer more than a regular
>     switch, and for that you need a MAC address. But the services should
>
>      Yes, Linux bridge needs mac address. Because linux works based on
> the 802.1D bridge
>      which has MAC relay entity,  Spanning tree protocol entity. The
> bridge required mac-address to communicate
>      with other bridges. For example to form a loop-free network
> spanning-tree protocol in the bridges will communicate with
>      the bridges using BPDU, the bpdus carry the bridge address to
> identify from which bridge we have received the BPDU.
>      If your bridge just acts as forwarding  agent, then mac address is
> not requried.
>
>     be provided by a new tap interface added to the bridge. I believe that
>     the bridge should not even be shown by ifconfig.
>
>
>      I am not familiar with tap interface, So ignoring it.
>      I agree with you that bridge should not be shown in ifconfig.
> Bridge must come up  when anyone of the bridge ports are up.
>      But in current implementation we have to issue ifconfig <bridge>
> up  to make the bridge up. As far as i see it is not required.
>      Hope someone can give more clarification and its purpose
>
>
>     2. Why does a bridge take the lowest MAC address of the interfaces
>     connected to it?
>
>
>         From 802.1D
>
>         7.12.5 Unique identification of a bridge
>         A unique 48-bit Universally Administered MAC Address, termed the
> Bridge Address, shall be assigned to
>         each Bridge. The Bridge Address may be the individual MAC
> Address of a Bridge Port, in which case, use
>         of the address of the lowest numbered Bridge Port (Port 1) is
> recommended.
>
>
>     3. When I send broadcast frames to a bridge interface (etherwake -b -i
>     br0 00:00:00:00:00:00), the frames are received by the interfaces of
>     the bridge.  But when I send the frames to one of the interfaces, they
>     are not broadcasted to other interfaces.  I though that the bridge
>     interface (br0) behaves the same as an interface added to the bridge,
>     but I was mistaken.  What are the differences?
>
>      no idea
>
>
>     Thanks,
>     Irek
>
>     --
>     Ireneusz (Irek) Szczesniak
>     http://www.irkos.org
>     _______________________________________________
>     Bridge mailing list
>     Bridge@lists.linux-foundation.org
>     <mailto:Bridge@lists.linux-foundation.org>
>     https://lists.linux-foundation.org/mailman/listinfo/bridge
>


--=20
Ireneusz (Irek) Szczesniak
http://www.irkos.org

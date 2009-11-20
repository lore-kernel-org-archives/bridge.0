Date: Thu, 19 Nov 2009 21:43:23 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20091119214323.365d5580@nehalam>
In-Reply-To: <959514.14125.qm@web8705.mail.in.yahoo.com>
References: <959514.14125.qm@web8705.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Regarding default vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: sunil saraff <sunil_007_xxx@yahoo.co.in>
Cc: bridge@lists.linux-foundation.org

On Fri, 20 Nov 2009 09:08:38 +0530 (IST)
sunil saraff <sunil_007_xxx@yahoo.co.in> wrote:

>=20
> Hello,
> =C2=A0
> I have two vlan=E2=80=99s configured on my switch port i.e 246 & 247. 247=
 is a tagged vlan and 246 is the untagged vlan(native vlan).When I create a=
 virtual vlan interface with tagged vlan 247 using vconfig(eth0.247) it wor=
ks fine. If I create a virtual vlan interface with untagged vlan 246 using =
vconfig(eth0.246) I see a different behaviour.
> =C2=A0
> My configuration
> =C2=A0
> Ifconfig eth0 0.0.0.0 up
> Vconfig add eth0 246
> Ifconfig eth0.246 192.168.246.3 netmask 255.255.255.0 up
> Route add default gw 192.168.246.1
> =C2=A0
> =C2=A0
> The packet that goes out from the linux box is tagged with 246 vlan but t=
he replies are untagged(as it is the native vlan). So these untagged packet=
s are not accepted by linux box. So, can you suggest me a way in which I ca=
n configure my linux box so that the untagged packets for default vlan are =
accepted?Can bridging be done on eth0(untagged interface) and eth0.246(tagg=
ed interface)?
> =C2=A0
> Thanks,
> Sunil=20

This is not a bridging question, it is a vlan question.
So post it to linux-net@vger.kernel.org

I don't see 247 anywhere in your config?=20

P.s: the ifconfig/vconfig/route commands are old. Use ip command instead.

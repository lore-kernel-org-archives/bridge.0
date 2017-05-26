Return-Path: <forwardinglnx@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=q8EqypjhqoenEe97FxWE5A6GFW85z/6QaCUdzv150Ro=;
	b=u8DGqEddi+7fCHAhOrXBWQRA6KUvcdsN0p5uKRXpKAo73U/IyFKPPtNLDQVeQcCgQq
	G5PUDVzwOqy2ceUElQxdLUm8uPgEXKnKTxyhLXVPgIF4oj3cOS2xQACbedzsKmex/p1E
	3Dn4sJoNpGvcirn4LAIaNceyyMMGQRbuIvizpt0v69aYf2jXGp/86lLCGDeEEjEmOZk6
	GHq42+FWtA+cIWUwqI33GIMRFx1vzVPj7WAUSSzSOYM2erE00Mfd+3955IsOZcVsGR0x
	KiTZodRWKKTFewa8wgZEQ+pht9OqstVlR0rcPxbLR6zFP9tyLZ55A03TRhRak1IBbqQ2
	nlZw==
MIME-Version: 1.0
In-Reply-To: <fbf9c273-d326-c26e-593f-ccf139bc0049@lab.ntt.co.jp>
References: <CA+N+6-xY7+coc6zFqzP665WMhbGFFMHOfre9wNxRAcSF2Bthzw@mail.gmail.com>
	<e6143108-3eb4-6f6a-c58b-857722f706b9@lab.ntt.co.jp>
	<CA+N+6-xtSgQ4eDN7SBMg43WXEc=6quPNE4L1-3xjLuTMte0DSA@mail.gmail.com>
	<fbf9c273-d326-c26e-593f-ccf139bc0049@lab.ntt.co.jp>
From: Manohar Kumar <forwardinglnx@gmail.com>
Date: Thu, 25 May 2017 22:08:05 -0700
Message-ID: <CA+N+6-wErt=9XX6u8tPnLbb2DrLqADOnCBn3mDe=qvxCoLCFyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] Deleting a dynamic mac entry..
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Wed, May 24, 2017 at 6:11 PM, Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
> On 2017/05/25 3:05, Manohar Kumar wrote:
>> Thanks, Toshiaki.
>>
>> What is the right way to set the default_pvid using the bridge command
>> ? I tried this, which fails..
>>
>> root@net-3:~# ip link set dev vxlan0 name untagged type vlan id 0
>> RTNETLINK answers: Operation not supported
>> root@net-3:~#
>>
>> All the interfaces in the bridge are untagged.
>
> # ip link set br0 down
> # echo 0 > /sys/class/net/br0/bridge/default_pvid
>

I have the bridge inside a network namespace. There is no
/sys/class/net entry for the bridge interface inside the namespace.

I see online references to this concept of 'tagged' sysfs directories
to support namespaces. But its not clear how to access the sysfs
entries for a particular namespace.

Is there any other way to set the default_pvid for the bridge
interface inside namespace ?

thanks for the help.

Manohar.

>
> Toshiaki Makita
>

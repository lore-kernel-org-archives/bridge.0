Return-Path: <srinivas.aji@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=/2Inr1PTgVLkx0NndfzkayYZfVIGw3dlMrgzcxdQRHA=;
	b=abjhkFX91odEi09M9DmDYgaQ21OB9cheTV7gJVWklEfusQiGJk1weuKRUT9yJ5xsvF
	6BgSZ9mbIU+KCMuZ7OKEUlt187r0bFZkFVdQOUm0G/Jr1Wbl+Ue0hQOQjm2rY0s46ltN
	+XmMDpLm0ceyuxf5YMI/kcQR4j6m6hDjlG7ObE4jC0zR1eP4nOHmWU2eZNfDk7bnUI1y
	v/tIPLQ9zEKetaaql5Loygz5zETMrk4MRb1HcXOZHi0N6JE31iPmLRZvg8dSNhrDg7u8
	3q+3qqp9aQ0zn9D24xul1fOnmqBrPInoDLwrad6v+08qO/VUnuNb5yjt28hBOudIZRw8
	fh/Q==
MIME-Version: 1.0
In-Reply-To: <5FA3B72D-03E5-43BD-B635-6A46070C6898@gmail.com>
References: <5FA3B72D-03E5-43BD-B635-6A46070C6898@gmail.com>
Date: Tue, 2 Feb 2016 11:04:04 +0530
Message-ID: <CANbryT-OrFoLy5APcXbrEEQSTAHQqfTH303HwV7d-jWM9mApyw@mail.gmail.com>
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Logan <djlogan2.dl@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Feb 2, 2016 at 1:21 AM, David Logan <djlogan2.dl@gmail.com> wrote:
>
> tap2      Link encap:Ethernet  HWaddr 8a:21:a8:cb:f5:98
>           inet6 addr: fe80::8821:a8ff:fecb:f598/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:51870 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:741595 errors:0 dropped:5702 overruns:0 carrier:0
>           collisions:0 txqueuelen:500
>           RX bytes:3220139 (3.2 MB)  TX bytes:1113177111 (1.1 GB)

You are seeing TX packets dropped at the tap interface. So these are
packets that are being sent from the bridge to the VM on the tap
device, but getting dropped, probably because the tap device's queue
is full. This would mean that the packets are not getting read by the
VM fast enough, or may be not read at all after some point, since you
see only the dropped increase after a while. So the issue is likely to
be related to the virtualization software, rather than the bridge.
Have you tried asking about this on forums related to the
virtualization system you are using?

Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:subject:to:cc:from:message-id;
	bh=vb+V5G1fB6s4se4aNOPSNT85ySMUe6CSa81Te8JBoRE=;
	b=Ws9ob7nauEn+3EsJY6I5+GXnH49DvTwHXX/MxLUJ3LY8uxK868wT+FZpNOmdrNlOgT
	xkdZCWfJ6AiUBpIoNJm5/bjk09IK4XLr+8YirI5DC0dOgbs//TjihQtEVMK8ymCVAWQ6
	v1pEcVGEFGd+XsMDjbejhcZ+W0iUpyWyU/DtQ=
Date: Tue, 15 Oct 2019 12:48:58 +0200
In-Reply-To: <CAFLxGvwnOi6dSq5yLM78XskweQOY6aPbRt==G9wv5qS+dfj8bw@mail.gmail.com>
References: <CAFLxGvwnOi6dSq5yLM78XskweQOY6aPbRt==G9wv5qS+dfj8bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <3A7BDEE0-7C07-4F23-BA01-F32AD41451BB@cumulusnetworks.com>
Subject: Re: [Bridge] Bridge port userspace events broken?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, netdev@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 14 October 2019 22:33:22 CEST, Richard Weinberger <richard=2Eweinberger@=
gmail=2Ecom> wrote:
>Hi!
>
>My userspace needs /sys/class/net/eth0/brport/group_fwd_mask, so I set
>up udev rules
>to wait for the sysfs file=2E
>Without luck=2E
>Also "udevadm monitor" does not show any event related to
>/sys/class/net/eth0/brport when I assign eth0 to a bridge=2E
>
>First I thought that the bridge code just misses to emit some events
>but
>br_add_if() calls kobject_uevent() which is good=2E
>
>Greg gave me the hint that the bridge code might not use the kobject
>model
>correctly=2E
>
>Enabling kobjekt debugging shows that all events are dropped:
>[   36=2E904602] device eth0 entered promiscuous mode
>[   36=2E904786] kobject: 'brport' (0000000028a47e33): kobject_uevent_env
>[   36=2E904789] kobject: 'brport' (0000000028a47e33):
>kobject_uevent_env: filter function caused the event to drop!
>
>If I understood Greg correctly this is because the bridge code uses
>plain kobjects which
>have a parent object=2E Therefore all events are dropped=2E
>
>Shouldn't brport be a kset just like net_device->queues_kset?


Hi Richard,=20
I'm currently traveling and will be out of reach until mid-next week when =
I'll be
able to take a closer look, but one thing which comes to mind is that on
any bridge/port option change there should also be a netlink notification =
which
you could use=2E I'll look into this and will probably cook a fix, if anyo=
ne hasn't
beaten me to it by then=2E :)=20

Cheers,
  Nik

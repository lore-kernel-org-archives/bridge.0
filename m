Return-Path: <keescook@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=7ddY0n9DmxsBrQryYo5J5Tj0NxhOod8aanhZ3kG7kIY=;
	b=EZvO3NTLh0uWWdU1kW0VZbiSrvH4pku452/ktBJ7zibxuQKdWCd55++sqfi5i5Kli2
	vMyERnS3rgQAqgMSEiFnj7Hs+5qVKrGAsTBCgkT5zCirGRw8jP6Fm0QLfHwbWAj023EM
	Mk/FIMhhIp7u2trZ5ycoWiEuChiNzggbshbF5vvQTDmD3J296PbX3fnZexuCDUIIuzQv
	qC9W3xjGZ8SjmBgC+nhdtwhdt5desYx5WA69Md8cEEuFslXpbDTtlyYviMsmVEcW6K2U
	1+usojC/dao/c71rSt7DO6J7H7Q6PsPD0OmfCA01l1NzZeKnUeDml8Dn3sZXGqZuH4hI
	zfNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=7ddY0n9DmxsBrQryYo5J5Tj0NxhOod8aanhZ3kG7kIY=;
	b=bhcjo7YAOvH8uIVjEiU9mgp46nQ4CKRd4G+nEqYVvyCt0XJuQg3+oJP1pC6V64BOXH
	fRwnBtguPwYmcv/tzRuAl3VjbBvpOyrK+gb2ztCvv0T7eJbQ8vxjXuZolPpCZfTEqf3o
	pdMz0F5ZOV4wQfTDV8qohrNqWUn1+IKvK4VTg=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <565B7F7D.80208@nod.at>
References: <565B7F7D.80208@nod.at>
Date: Mon, 30 Nov 2015 12:14:41 -0800
Message-ID: <CAGXu5jJqQKAmFK0nL69E0QOpo8WSVDqStGZo7-m7gy3vnXBa=A@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] user controllable usermodehelper in br_stp_if.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>

On Sun, Nov 29, 2015 at 2:43 PM, Richard Weinberger <richard@nod.at> wrote:
> Hi!
>
> By spawning new network and user namesapces an unprivileged user
> is able to execute /sbin/bridge-stp within the initial mount namespace
> with global root rights.
> While this cannot directly be used to break out of a container or gain
> global root rights it could be used by exploit writers as valuable building block.
>
> e.g.
> $ unshare -U -r -n /bin/sh
> $ brctl addbr br0
> $ brctl stp br0 on # this will execute /sbin/bridge-stp
>
> As this mechanism clearly cannot work with containers and seems to be legacy code
> I suggest not calling call_usermodehelper() at all if we're not in the initial user namespace.
> What do you think?

I'm not familiar with how bridge-stp is expected to operate with a
network namespace, but if it's meaningless, then yeah, that seems like
a reasonable change. Can you send a patch? (Also, if it's legacy code,
maybe it could be turned off entirely, not just for containers?)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

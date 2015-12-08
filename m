Return-Path: <keescook@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=eGFYzYaInhvSxswFmpg1gEqXJ45sqgq/PPHESUSyKB4=;
	b=DNHTX2uc/iwtSpnhxZka+7l71oBjWinL54/5YTQL24yUGqhGbHYYV4RGf8corvYBmk
	b/Cd4kiME3tFxoRjMhI7mvLbnxm1iMPAQV4IWg8imJ4tpWC368qBzyPPQ6nLaycrFQvy
	xC2kwv1Z49ZzpA400pp04ZFYQ8N8+KCdVt1MaPuPoExMcsBXw8kpiu58/vw/Kl7oln6S
	vFr33DxHhyO2zdEUDac1u5z+8WGD91Jj3Ei6gClzim2jJkU+aepsNaksS6q5w5iJA9En
	bjYn9SL4USILsvRf8WkD8O/SAZG6dh8wQFyf65OdtTpzal37S+S72NAyFoQRan/RQXO/
	zV7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=eGFYzYaInhvSxswFmpg1gEqXJ45sqgq/PPHESUSyKB4=;
	b=SPumLepNSMi7z4314q2xZEWTbiKSJdyukxutjnZ6Tw5Y6xUz9zNGtAp3JlyfXXsXbF
	XYWndU5IMBeF8DsN0m2TDF08YmzMz3a8eZw5H5ZPFqlB9nJdLYvs1FiR/eoM0QrqM23z
	LfWne4nBsirK9bowU0h86nwm3/cgYsmwCP2Dg=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20151202.235049.2068953758962834535.davem@davemloft.net>
References: <565B7F7D.80208@nod.at>
	<CAGXu5jJqQKAmFK0nL69E0QOpo8WSVDqStGZo7-m7gy3vnXBa=A@mail.gmail.com>
	<87egf7183c.fsf_-_@x220.int.ebiederm.org>
	<20151202.235049.2068953758962834535.davem@davemloft.net>
Date: Tue, 8 Dec 2015 12:56:43 -0800
Message-ID: <CAGXu5jJJ-cYuckKPbmLejEZ82FY5eWR5R5MVRgxgTD+7hHZ1gg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net] bridge: Only call /sbin/bridge-stp for the
 initial network namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Richard Weinberger <richard@nod.at>, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Network Development <netdev@vger.kernel.org>

On Wed, Dec 2, 2015 at 8:50 PM, David Miller <davem@davemloft.net> wrote:
> From: ebiederm@xmission.com (Eric W. Biederman)
> Date: Mon, 30 Nov 2015 15:38:15 -0600
>
>> +     if (dev_net(br->dev) == &init_net)
>
> Please respin this using net_eq() as Hannes pointed out.

Sorry if I missed it: this this happen yet?

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

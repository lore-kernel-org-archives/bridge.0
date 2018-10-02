Return-Path: <richard.weinberger@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=NRskqF0KnSDKbrrFoo8MPu4EgTOhERon8rKTLVSNI/Y=;
	b=cOk1mwsSIM/m2KakMu7jsU/iTeba467pTAFOKouZe7JOKKAnM8Vk96mQhIqhSiIdpc
	pRbciPg515Q2qGzLn/UDjno+Z9Te7DtFo2NmYtjNtw22d9Z8ohdHxexloxT4BQqxFZ+h
	+UqyeNCXzmcnkmxbsnvOcSyAC1IFTrCtX3mkSWUEacdSFqynWego4z7rmQdk9iaBFgwn
	yytGzEYKMLdD9oEJ4gIc9PB91LxHx6xLQnaI3Z0tylbPYNui3PI8PbiqRMbUajJa586I
	bJ+gCJdAoYxvNq3ScxnikBtYI/G4ThqjCnkS8a0uCUY0yvcrRjxcJre04yThilwKPGSN
	tOsQ==
MIME-Version: 1.0
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<16029249.TkoLblyBmC@blindfold>
	<09307ccf-02d6-ce63-7030-fcc560e93f23@cumulusnetworks.com>
	<1694684.hdcNQnb4e4@blindfold>
	<102873a5-ed43-2bf7-9ef7-70a76c5b7f6e@cumulusnetworks.com>
In-Reply-To: <102873a5-ed43-2bf7-9ef7-70a76c5b7f6e@cumulusnetworks.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 2 Oct 2018 21:30:38 +0200
Message-ID: <CAFLxGvzx3jE9SbHio7_ftpUrG9r+Zn_XdWU+xb=4K7YgQP6gyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH 1/1] bridge: remove BR_GROUPFWD_RESTRICTED for
 arbitrary forwarding of reserved addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: David Gstir <david@sigma-star.at>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@idosch.org, Bernhard Thaler <bernhard.thaler@wvnet.at>, "David S. Miller" <davem@davemloft.net>

On Tue, Oct 2, 2018 at 6:48 PM Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> > Is there a reason why this knob is not documented in Documentation/ABI/testing/sysfs-class-net?
> >
>
> Hmm, I don't think any of the bridge knobs are documented there or any other master device for that
> matter. Most of these options are documented in ip-link.8 man page from iproute2, it seems though
> this one I've missed to document. I'll prepare a patch for iproute2.

Well, /sys/class/net/<bridge iface>/bridge/group_fwd_mask is
documented, this confused me a little.

-- 
Thanks,
//richard

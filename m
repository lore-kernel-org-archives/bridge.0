Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=xM/HtOP5ocezd9MWCf3yZ/rnQ0vCezsxpE8LmIpEXzk=;
	b=Om8JNvOLhRgJ2XezQU1oOtZrdMv6x7MhRxjdGvYKGQNfwT8eqls0b69zlO/8WICZQW
	A6NEMqzL2avnmouiga+xK8rmMCe9W5BJ52KJ+SdlL+YTp/hO+4IycFsEAmxOgnRPZ7u/
	gaYCYcu8X2Dht0iZBuMqa/c7XkmDKhZHfOdmbP+8BJSCfeAKVj4xwS+BL0i2NPKqVI4n
	YWFga3xUV6g6dIobM6vmk51HRdWVgkTC+FEQRRmTjI1r9I1tj6Yq5d2x+bxfXiBAGMtY
	TN1Ha9UHoIMiB6kuYM+GDDtZuUmMkpY3/VQ8iBTTOIpkbDaOFHmfkt2YlEXn1kPhHJmB
	+Ukw==
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAB=NE6WKyQbh9Eih05szW6708fVTNPgTe62SU5tC2dQkqwJApg@mail.gmail.com>
References: <1394680527-28970-1-git-send-email-mcgrof@do-not-panic.com>
	<1394680527-28970-2-git-send-email-mcgrof@do-not-panic.com>
	<20140318201056.7b876394@nehalam.linuxnetplumber.net>
	<20140320020540.GF28801@wotan.suse.de>
	<CAB=NE6WKyQbh9Eih05szW6708fVTNPgTe62SU5tC2dQkqwJApg@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 30 Apr 2014 11:40:04 -0700
Message-ID: <CAB=NE6VZNiJaag7mzMxk02+EjXLoyK=Uwe+YK+M+54UcVV_AEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH 1/3] bridge: preserve random init MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xen-devel@lists.xenproject.org

On Tue, Apr 22, 2014 at 12:41 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> Stephen, I'd like to respin this series to address all pending
> feedback, I'd still like your feedback / call / judgement on this
> part. I'm fine either way, just wanted to ensure I highlight the
> reasoning of why I kept the original random MAC address.

Re-poke.

  Luis

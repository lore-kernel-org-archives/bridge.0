Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PL3yO4+9b5Kg0eGT8dzywNhl3Ige7J/+FhNyrZejpQw=;
	b=VwFutL/KQpJ4ygvQa/hTSt6rhMXSQpmF2OrcrxE9QJVUdk1HAExDoNIHRUZ56lA3/3
	HIC8FblaARPI+suKbJxnmJhSjrkJ1MBA1MhHfTWH+EFxZFEhYBts3HP3Pgcb0L2IV4JJ
	NqWo9s8NI/WE/RFHILeJ4R7XhQHV/PJDJLx8S+RMIu914uQHb1876NrV+8q99Q9dikuc
	aAsh7GD8cXwhhYnwF+R9phpS23z1OuzxiSXMaTqTpecF5gwUNE+ogaQ01Zu1oSp+CoOq
	68ClSg7ZQNEzl+TdMx/szvhk+UDwVUnyHZBvk+MiCLGyWwaKhM4xnfn0S7aoAh6SVsD1
	Wg8g==
Message-ID: <1499077817.1462.8.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 03 Jul 2017 03:30:17 -0700
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B6FF2029D@IRSMSX102.ger.corp.intel.com>
References: <1498817290-3368-1-git-send-email-elena.reshetova@intel.com>
	<1499074136.1462.0.camel@edumazet-glaptop3.roam.corp.google.com>
	<2236FBA76BA1254E88B949DDB74E612B6FF2029D@IRSMSX102.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 00/17] v3 net generic subsystem refcount
	conversions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "peterz@infradead.org" <peterz@infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "jmorris@namei.org" <jmorris@namei.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>, "kaber@trash.net" <kaber@trash.net>

On Mon, 2017-07-03 at 09:57 +0000, Reshetova, Elena wrote:

> Thank you very much for the report! This is an underflow (dec/sub from
> zero) that is reported by WARNING. 
> I guess it is unlikely that actual code underflows, so the most
> probable cause is that it attempted to do refcount_inc/add() from
> zero, but then failed. 
> However  in that case you should have seen another warning on
> refcount_inc() somewhere earlier. That one is actually the one I need
> to see to track the root cause. 
> Could you tell me how do you arrive to the below output? Boot in what
> config/etc. 
> I can try to reproduce to debug further. 

I sent this fix : 

https://patchwork.ozlabs.org/patch/783389/

Thanks.




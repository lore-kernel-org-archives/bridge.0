Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version;
	bh=Ado5/RRGPfl+5rcQVDmZbWYgHNfqMprpn9Gy/3uHFBQ=;
	b=R9YrDdQ4fnpv3esp568Jv/cqKGdBFM3CwlN2NSZIVu4YFjf3qEkYySkPlP/u0d12KI
	QI7t+XcxKJDShB+PFwJxm1wvrgT9WP0PQrsW1/NcvoOQk3xTR2MIYFvypfpaejI43NUW
	f2ZTGR2dwI8Su9LzZKXjMRLYG4/q9j9z9cC0QnWv1831VRQkxz9uVWDXxj7jwPxqut8r
	WRPab6W9lEfvOw1IMH4o83qEn5+lhbnbRCpj9UN3MFxKOl/DY5RP7Em1Xe1E7k9Ksngy
	NiYeCE90V8Uc1CffohiEDcsZ4MGd158kbNhD9rE1a1Cv4a9PRyDE3fpOd5vo8uAmaWsr
	9xrw==
Message-ID: <1386256758.30495.195.camel@edumazet-glaptop2.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 05 Dec 2013 07:19:18 -0800
In-Reply-To: <20131205150158.GA2626@minipsycho.orion>
References: <1386255025-23823-1-git-send-email-jiri@resnulli.us>
	<20131205145842.GD23147@redhat.com>
	<20131205150158.GA2626@minipsycho.orion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [patch net/stable] br: fix use of ->rx_handler_data in
 code executed on non-rx_handler path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: jtluka@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stephen@networkplumber.org, edumazet@google.com, laine@redhat.com, zhiguohong@tencent.com, davem@davemloft.net

On Thu, 2013-12-05 at 16:01 +0100, Jiri Pirko wrote:

> I know. But makes more sense to have these getters here, near the
> struct. I originally moved the definitions near br_handle_frame_finish
> definition but I think that it is nicer to do it this way...

No, this is really ugly.



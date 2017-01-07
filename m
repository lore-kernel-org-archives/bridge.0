Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HqMTbCWSfnW2iygd8S3qIxs+5b3UuvJjn6Tu1L46aIo=;
	b=jWYUbqSPKXQ830ciUlET0l9Dv8KX97mBUr6LGVcYk1WQ/LzrQQCDId7vU9P9oW3U3j
	LrhsDfF/ylu1R5aXGsJJ5UxEalTxWHnm/aAcuDSq1mjxvbjTQPPVs8AlTGFmSHXU6UEW
	/lQ3eUwT0rFhvpOk+s07l9wpH4Go6rIMRRu+mXwhDVw0PMgc+aOQ4JkaBWgtoC1uw2hL
	pKAU5KQFAGuFBtYxI+EjDLjWBFX+xO0WeFbQsCWU2QB4MgUPlcb8XJMzav+EaAzSNVj9
	wEZmUWSArZLDHhufKcsFyaoOHP2yGqXoYDAUIlEj4GQfdEGE5UynvpOZE3/RGHYFQD5H
	knBw==
Date: Fri, 6 Jan 2017 19:13:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170106191356.43740a26@xeon-e3>
In-Reply-To: <20170102193214.31723-1-linus.luessing@c0d3.blue>
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>

On Mon,  2 Jan 2017 20:32:14 +0100
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> This feature is intended for interface types which have a more reliable
> and/or efficient way to deliver unicast packets than broadcast ones
> (e.g. wifi).


Why is this not done in MAC80211 rather than  bridge?

Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=h50wuIkgPy/qyFGSaZxSTYNZJN7wATVvm0UweSkAxxc=;
	b=RC1/aUTcVkkn96aP43fi1L6JH8LFFZGpK5qk7i1h2cC6BZTudzXnBI/je4g3ydqZJg
	GB95wJ3wCMS18xlKjn2PvuIXg0T8rG9OHKH2HVF+np6kUhPYOlVnpuSvdsF0CAwVxje0
	8LA6YQ7GHA470Xx/aX1mS357fQhZTOapmgW/T3Kd8LDTfr8FAwC+sdTW7pmYSW5gSQFg
	a61/6L8etNfi6fQKQzsp/cMFVmn3rJqN3fo7HKuCOWSvpJVGZCkM2cVQd+1ZxvYdCl7V
	60oRwJyOVF1nBewQWDpiDFH017yPdr4cVB1O1CubqscOXIfMRcwKmQMPrEdUXl89tPod
	QDLw==
References: <20190216045556.3514-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3ee70578-e2d7-d890-fb36-9ac11dde96d1@gmail.com>
Date: Fri, 15 Feb 2019 21:00:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/9] net: Get rid of
	switchdev_port_attr_get()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, David Miller <davem@davemloft.net>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com



On 2/15/2019 8:55 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series splits the removal of the switchdev_ops that was
> proposed a few times before and first tackles the easy part which is the
> removal of the single call to switchdev_port_attr_get() within the
> bridge code.
> 
> As suggestd by Ido, this patch series adds a
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS which is used in the same
> context as the caller of switchdev_port_attr_set(), so not deferred, and
> then the operation is carried out in deferred context with setting a
> support bridge port flag.
> 
> Follow-up patches will do the switchdev_ops removal after introducing
> the proper helpers for the switchdev blocking notifier to work across
> stacked devices (unlike the previous submissions).

OK, I really need to use the long weekend break here and stop sending
stale patches series apologies everyone, work will resume when I have
put my head, hands and keyboard back together.
-- 
Florian

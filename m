Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E8q+sxQ/OKWc9Yjv2NdwSWvKkf3e/JsO3sjkasoj5T4=;
 b=PFbCjhOF3i/Qih8MWpNpCV1WDr1IkD812JarIXVhPKFUS9GojJTTe9Laxl6eXH9Ox/
 lI5XNcYavP+RTWIGHN7tfcaET9UVWn70R26wRRPg0q6y1T5yr6QdY3wIghHroOC6Kw1V
 XGzivzeBTQU9Cn3p/4OYMqb115LRSNYarpmjRC4rgVLAeC8p2msJQ6SZN3OGyn8OwbAJ
 nsBXbx8ENY96O0ku0YZc9gJysN8/aiYyMetHRXBGhhTGlhIr4dhITRRQxTC5Mqt3uzkI
 8QYa6s47awW6f9ZQT986o03QSi7re61pvRzgVt7aej4jGk64HrmMbl/BKbxU1oLw15an
 x+1w==
References: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
 <20210721162403.1988814-7-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dce98c0f-5ec4-8a54-209e-7891d239fbc9@gmail.com>
Date: Wed, 21 Jul 2021 09:27:31 -0700
MIME-Version: 1.0
In-Reply-To: <20210721162403.1988814-7-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v6 net-next 6/7] net: bridge: guard the
 switchdev replay helpers against a NULL notifier block
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

On 7/21/21 9:24 AM, Vladimir Oltean wrote:
> There is a desire to make the object and FDB replay helpers optional
> when moving them inside the bridge driver. For example a certain driver
> might not offload host MDBs and there is no case where the replay
> helpers would be of immediate use to it.
> 
> So it would be nice if we could allow drivers to pass NULL pointers for
> the atomic and blocking notifier blocks, and the replay helpers to do
> nothing in that case.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w7nShgb27jDKQVYMgG8IWKFdPwetpVboImcgOULQ/YY=;
 b=qR9Hpg7hczMNvHldptKxCfeB8bnltYjFNGAOrpLxJ0fjxgsH0TEcXKePOdb0+4zHhx
 i+CbS7QUfObSIbiml7hczxclRzY0HSE1+3QEDRu17782crlKU5YHbbRMy3vimhwu7APq
 eSh0AvLSGFINfmH/bt9Xw+HZgWKFII+zKS8wSJxw63AzKMi8CcnpY5iDwUqWKAFBpRXw
 4MxbuC+h8CsW2voXsxUCTtzZj78VTwScpq36K4/bckp5+LqbfEetWhMdY+29w48N9BcK
 k3nmrYVGECTm4vHQB9c5tHTlVz6TWXsb+5eScLxNFBWGkIfU050wQZY36WcQnvvrj8ZR
 oPTw==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-5-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <64fc7812-3c86-14ad-8245-ed84fc488b95@gmail.com>
Date: Sun, 18 Jul 2021 19:16:56 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-5-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 04/15] mlxsw: spectrum: refactor
 leaving an 8021q upper that is a bridge port
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



On 7/18/2021 2:44 PM, Vladimir Oltean wrote:
> For symmetry with mlxsw_sp_port_lag_leave(), introduce a small function
> called mlxsw_sp_port_vlan_leave() which checks whether the 8021q upper
> we're leaving is a bridge port, and if it is, stop offloading that
> bridge too.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

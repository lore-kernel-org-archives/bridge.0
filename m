Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E21E402F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 703C5401A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QXljKXuwBMk+OsTizGOu0V1MtZuYBJCVki2QOtDb+JA=;
 b=OtzHTh38wbeW2+6DHRuT1bY8TboZWM4dFCb6TBS9e1+tDi1D1ZvCmpOlplrc1i+ztF
 ZX2vgGiyJyNktp8r4rmEw0fL28JUGOXaLQ1WRYWyZBlcDN+hz85qzuggWg18uTzRn4Av
 x+kj6HuZ9BlzqqabI6XxwdMRG/FkHVca3SD9ocKIgkTMvssmNPe7EjvTY6bOX7QTME/J
 0i9pHg4QjVRA6iSylbNkdmajOUOnbBRxr6nBREamUrtf6bR3QBcVH/pd/rJhS7Fvnn7c
 unTlRqhZDq+d45OkF1ZSFlGzY+WXRvR4nl8gYzAHN63JRF9DlY70TODN/DKcYyStYdfW
 peeQ==
Date: Tue, 8 Nov 2022 16:42:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108144248.daycrsxaxvwokxfj@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <9fb8b83ce2029c51c81c942f24ece789ae8fe1c1.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb8b83ce2029c51c81c942f24ece789ae8fe1c1.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 15/15] selftests: mlxsw: Add a test
 for invalid locked bridge port configurations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Nov 08, 2022 at 11:47:21AM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Test that locked bridge port configurations that are not supported by
> mlxsw are rejected.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CB0960761
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 878C760701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4y4rUaYbaz7MBG+9S3FNKhXxJIErUw0KZK+KgNc8tMo=;
 b=A8Eq+ntcGL3Xt10xRJMXfXhZ1Qs1giaozPNWkvbzUZ347P77mULNlBzwkrCmSXhGSr
 aHUsZHSzhpWG3OLyFw8aMC/5wdE9xbLncQ73fIEnIq1oMjT2t76tLQ2p/GI6j55sp+zF
 72OusR6esKv56luQvm2H59r4aMf7LLjZe+LsyiJVOp0xsacn4BhfHB+MZulleSKYlZCO
 ye4Jj2neq+m7mv6QhkRRBgfoLVlQb83vlDmiGxfUlV/S6EWrdrMSMB4zcb9Xj6uxyt8x
 cDx15ui3J3ZYfP2ij+bzZ0LNrHXhC3G9gRmWIGM2QmWro/huTKFivDKtu8dH1ZzRgzPu
 mbvw==
Date: Tue, 8 Nov 2022 17:11:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108151122.bjhi3rmqpofmdeqa@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <cover.1667902754.git.petrm@nvidia.com>
 <389ee318ff1a799d1e94ba1a33ab2ff42bae50fc.1667902754.git.petrm@nvidia.com>
 <389ee318ff1a799d1e94ba1a33ab2ff42bae50fc.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389ee318ff1a799d1e94ba1a33ab2ff42bae50fc.1667902754.git.petrm@nvidia.com>
 <389ee318ff1a799d1e94ba1a33ab2ff42bae50fc.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 13/15] selftests: mlxsw: Add a test
 for EAPOL trap
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

On Tue, Nov 08, 2022 at 11:47:19AM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Test that packets with a destination MAC of 01:80:C2:00:00:03 trigger
> the "eapol" packet trap.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

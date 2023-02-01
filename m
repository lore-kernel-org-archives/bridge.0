Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C8FB4091C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3168540739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675275947;
 bh=+ysKNM/qX+vUFh7ls46wGK+gSEJSUWfzN8v7hHVOH0g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jCsQxnDvbkdPXr3c/jbkTbdPBO5OjzBe2P2sADtfmFOt5CYeqCV0kAMpICSZu+snk
 pY/Fuf5kE/fjnZ03HopADqksMCchKJIUYeWr1pknUFZo9o6zFRFtEZwxJdY8zmvllH
 wHCEoBHWha3YrGRDwbSBRhD3Q1Jb/yfjhZl2zjtR4iH4Wmd40cNlM/DjTzyvLdUJxg
 pGImQZJKDjSHPVcZa0Rdf4CKErmjcLk85YqMeE8Vxy9ZsDozcwMuix8/fLRggJ0HEQ
 DokvVRHaiFhpp2gYMYgJx2KADGULReG8jNq0OXvF3GEu4OeTkK/dy/3PORCENUbYm6
 tL9yZV45YVQ/A==
Date: Wed, 1 Feb 2023 10:25:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230201102546.1d1722ae@kernel.org>
In-Reply-To: <cover.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 00/16] bridge: Limit number
 of MDB entries per port, port-vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, 1 Feb 2023 18:28:33 +0100 Petr Machata wrote:
> Subject: [PATCH net-next mlxsw v2 00/16] bridge: Limit number of MDB entries per port, port-vlan

What do you mean by "net-next mlxsw"?
Is there a tree called "net-next mlxsw" somewhere?

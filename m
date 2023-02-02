Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AC826101F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFF2A60E89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwQ1N3im10iQazwDr1bRs5UHQ4d4kNZidTz1eauJXQo=;
 b=dMNp/hQepaoE9lhAgHWRol1nUi8luY4ESuEQmkoGm82vdOxRoJaDQC3ICFn2bRclfg9VpzswtQcKI9WeTg3Ogokgcz3t9GWgk2KbXbFV2kbFGBxcRzSNkEkkcr2px/fZHpaxTPJbDLN90LMV90kr33L4CYSiisoqSb94PwD8iaZtY3fJiWfWD0qTOzxvW2EL1gNNVG4MAI3/V0gCmLQ9DiYQr5DnVyomrDrlkv5O8425wHl9OgrN29ij/ak6Dl86b3mg7K9EWTn1ZKneuGqMmzS0Mjc+zFIVKzb/ruiz1Y+7o0OcDCKzyJ+P/ZJ7hYGuxSvDZcPrrVok/aXuWTzc0Q==
References: <cover.1675271084.git.petrm@nvidia.com>
 <20230201102546.1d1722ae@kernel.org>
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 2 Feb 2023 11:07:10 +0100
In-Reply-To: <20230201102546.1d1722ae@kernel.org>
Message-ID: <87zg9we5vp.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 1 Feb 2023 18:28:33 +0100 Petr Machata wrote:
>> Subject: [PATCH net-next mlxsw v2 00/16] bridge: Limit number of MDB entries per port, port-vlan
>
> What do you mean by "net-next mlxsw"?
> Is there a tree called "net-next mlxsw" somewhere?

Sorry about this. "mlxsw" is our internal tree, the tag slipped in by
mistake. Can you simply ignore it, or should I resend?

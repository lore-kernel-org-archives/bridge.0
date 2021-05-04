Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps1;
 bh=hb38XH+yM07WGRcGwGh5Vt0v+WlRZZP2QH2DF8kYNzQ=;
 b=fTOPYw/uMIBR1rD5D7XIVWAzdlDmXXzwlcyQErxqsl3yLoU/Vrle+8ZKe2Bfdqc4FmiC
 NDd+t5/dU4UVjwRozGwoITMEK+6DpvUlEKu62MicrtdDZbDbHTxP39dPuabvLRjHg27L
 9MrIYm6agMzOgB5ZT1M+CYlfdb9pyShGOoLfhWm4o0r5oJZlL+VsnyZWNTx9JFbUcYD0
 wccCNrTaB+Kwbdz8yHnRA9EJGKDB3A6djrT2Y0HiZ4rbfigOoLEUPvG/kqlpMCIX72Iv
 8wu+AfcIDGu3tS6iShDwrUJYax4s6dhFnh47ntwXJj+GYoERhU+mFGK50PrdIZM+qZoz NQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb38XH+yM07WGRcGwGh5Vt0v+WlRZZP2QH2DF8kYNzQ=;
 b=Gdyac/GgN9nPZV2BBRzwnGRnjjPu416QLjtbuT6f1EjCaiRBF+FEG6gvdKRw7xLVg3QmonlH1d4elOW83+0M0OB/AvQbS2bKIW/KqW+NDlssw28hx3xhf6S2UrgJ8VMMWQKmu72bm+n5gNuRq4gsqDgWVOVvNsFbl2eET3NwuEg1DBkzY73lUQXK0sq8lCPWmocGNJ2ql2/+Bh+0HdzUiu+PobqxjJOIkR3geYhKH7dRcPLcC+zgKauiSOeXd7YI9zs7IaYA4AocXxjjrU9Cz5NNbQi4QUGhZAJ0mUKZ60JnW9bH6+/mg4wfihLlZHXEEFkc8WzFt5GG2RFNBs9SLA==
From: "Huang, Joseph" <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 20:37:45 +0000
Message-ID: <685c25c2423c451480c0ad2cf78877be@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>,
 <6fd5711c-8d53-d72b-995d-1caf77047ecf@nvidia.com>
In-Reply-To: <6fd5711c-8d53-d72b-995d-1caf77047ecf@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net 0/6] bridge: Fix snooping in multi-bridge
 config with switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@idosch.org>

> Hi,
> This patch-set is inappropriate for -net, if at all. It's quite late over=
 here and I'll
> review the rest later, but I can say from a quick peek that patch 02 is
> unacceptable for it increases the complexity with 1 order of magnitude of=
 all
> add/del call paths and some of them can be invoked on user packets. A lot=
 of
> this functionality should be "hidden" in the driver or done by a user-spa=
ce
> daemon/helper.
> Most of the flooding behaviour changes must be hidden behind some new
> option otherwise they'll break user setups that rely on the current. I'll=
 review
> the patches in detail over the following few days, net-next is closed any=
way.
>=20
> Cheers,
>  Nik

Hi Nik,

Thanks for your quick response!
Once you have a chance to review the set, please let me know how I can impr=
ove them to make them acceptable. These are real problems and we do need to=
 fix them.

Thanks,
Joseph

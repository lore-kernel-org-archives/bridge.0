Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=dxiyrkbJ1gI5e17uMzQYH9HmVd7ZbYHU6cmKHA1Eej8=;
 b=0oHfHkL/8/Z16pZuFdu0PP47aaLJV+vInQ3Fxy4U4AodZi8XUZlTg3a/1ht0zAVdLY
 s6Whd9eR+N/3AImhOeUnVLZgUhjbuHeVArpbEw35DyEZ81UAV6POd2oPLDEJgqzFh9Qg
 CL3n3TjznoMqoh9/NF5sr4uklZ9bUvXGTU3YcNVt7lHtjORFxfub2c6LEasA8eAdxNiT
 KxpPuz/m+7f0Ba08nzJeGySdf/qI7U5pDDW1VrfnQo4nGnSqJC/aN+B2LKXUUW6zP0vs
 IoNFrvsPbEVjrBtoYZSb931PPENHwYQoqJOk7GCotozPfvGb3+1lB/SMAXNHWVw3/TZP
 mH7Q==
Message-ID: <bf4ed31f-a2a7-a423-5ef4-5cd42b9889de@blackwall.org>
Date: Tue, 12 Apr 2022 16:32:34 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220412132245.2148794-1-razor@blackwall.org>
 <20220412132245.2148794-8-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220412132245.2148794-8-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 7/8] net: bridge: fdb: add support
 for flush filtering based on ndm flags and state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On 12/04/2022 16:22, Nikolay Aleksandrov wrote:
> Add support for fdb flush filtering based on ndm flags and state. NDM
> state and flags are mapped to bridge-specific flags and matched
> according to the specified masks. NTF_USE is used to represent
> added_by_user flag since it sets it on fdb add and we don't have a 1:1
> mapping for it. Only allowed bits can be set, NTF_USE and NTF_MASTER are
> ignored.

err, *NTF_SELF* and NTF_MASTER are ignored


Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Auj42wKcECcnklt6KoxYruKINeN/YRt0HTEgWQUvSbk=;
 b=trKaLQcY0Yt+MaFoeQX72QMgkuS5ppCOlNREaVS7jA73fXvLoyc7ULKKjY4nZXSvpb
 PAWHAjW2yBatHxPF21LM40sYwNnc0oT01X7OtZhPA65Blrr4xDZrt3YVuLS6rl3lkgGG
 qGdKrKHFuXoeQQ9/dhxBX4+2e5JzFER+NnKiU5FFpm/LZucICodXrX4AZJNcOwQFs4by
 1HZEjYX5Ev2wrsD8Z6/cy8LNMwZrr5UseaxFnzXb3tEajr3lPLnCMXJwpnSk3XJxpJto
 02FW+5u8/k7oc1hck+7sNYGTQV+G61KbOnMiUm6QlFH2vykPa7I8ht0+WeQS09VSChWa
 5omQ==
Message-ID: <24add056-e0d2-bf4b-9d56-04289bedbf15@blackwall.org>
Date: Thu, 17 Mar 2022 15:54:43 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-2-schultz.hans+netdev@gmail.com>
 <YjM7Iwx4MDdGEHFA@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <YjM7Iwx4MDdGEHFA@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 17/03/2022 15:44, Ido Schimmel wrote:
> On Thu, Mar 17, 2022 at 10:38:59AM +0100, Hans Schultz wrote:
>> Add an intermediate state for clients behind a locked port to allow for
>> possible opening of the port for said clients. This feature corresponds
>> to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
>> latter defined by Cisco.
>> Only the kernel can set this FDB entry flag, while userspace can read
>> the flag and remove it by deleting the FDB entry.
> 
> Can you explain where this flag is rejected by the kernel?
> 
> Nik, it seems the bridge ignores 'NDA_FLAGS_EXT', but I think that for
> new flags we should do a better job and reject unsupported
> configurations. WDYT?
> 

Definitely, I agree.

> The neighbour code will correctly reject the new flag due to
> 'NTF_EXT_MASK'.



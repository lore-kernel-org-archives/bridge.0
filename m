Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B22F681FC5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF23E813B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534967; x=1698139767;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y8g2g7raXC6KSNLGw7ZLxZ1tqI+faJNv/2CAMfuJSXs=;
 b=fFeNiuQhb2+LksI7G7ZHfdmzhdv9VA5lr61vBQECuH7iicX6Lv5IslzwWDvjA37+wn
 lyqDfMDGR+MPIc6kIrvUXlw0HoLm6L6VtR8Ot1ky3bc7XZCE5+hcEzjLl23WER/5uszd
 wxhETTa5uoc9ISyO3+6SBc/2OJalYn7Ys0gb5KxR3TxuDNOVLk3BiJvFVaOgMfd9Edpg
 HDNh103eo9EWdJW3HVVAYa+YUd9jlfCaQH1fRPiB5wCgvXyOsEaUnD+/bftGdGAzv4ii
 ZrADBrYmwmaQmuLdS2AAFg1UXJmxvQpojsUTPEvzNNl7OchOFotmHFvrPh6HQCEtp1Ij
 eEHA==
Message-ID: <80dca841-6cfa-e176-431a-9800183ce986@blackwall.org>
Date: Tue, 17 Oct 2023 12:29:25 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-12-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-12-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 11/13] rtnetlink: Add MDB get support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Now that both the bridge and VXLAN drivers implement the MDB get net
> device operation, expose the functionality to user space by registering
> a handler for RTM_GETMDB messages. Derive the net device from the
> ifindex specified in the ancillary header and invoke its MDB get NDO.
> 
> Note that unlike other get handlers, the allocation of the skb
> containing the response is not performed in the common rtnetlink code as
> the size is variable and needs to be determined by the respective
> driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/core/rtnetlink.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 88 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



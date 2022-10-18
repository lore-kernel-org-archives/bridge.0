Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8FE660FEE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46CE760FEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yxuQEGrIO8vmCslS3QuI3tXzAw6DQgSClcUN2Vo4mcw=;
 b=jtfgTY9eXvSBQ8QQS3vP7sFZZ5Zac6fDuYv5BXUkk/Dzc5wKQ+CtAr++Mj7qWKHttl
 dQ2/7pm0ZI2RfjydiNIbCiqhTwRNLcRX92KUmnWvqhkNMrG1JbljzpA2Dxw9D84SvGMW
 cxJnkTLop9xkURaeRj3IpLehpz2/ERgjWKVbAk4m2QRn7xYAVaGsb4rofHEXoTS2HfMx
 1cdedvj9lQvCyEBB7c5OWliit9q/g+9CG2IHCBNzkEu5JqR/i1+47xsES8vMadfEZZRr
 qCyK7sisl4QGJIw+GIvZibLk6Uy1DRy3EV2Mp3qVpjOfEu8VYNmhbzJy06d4s/HKEK0X
 qzjw==
Message-ID: <04d81c6c-33e3-c780-f546-c5050444620c@blackwall.org>
Date: Tue, 18 Oct 2022 11:37:04 +0300
MIME-Version: 1.0
References: <20221018064001.518841-1-idosch@nvidia.com>
 <20221018064001.518841-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221018064001.518841-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/4] selftests: bridge_vlan_mcast:
 Delete qdiscs during cleanup
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

On 18/10/2022 09:39, Ido Schimmel wrote:
> The qdiscs are added during setup, but not deleted during cleanup,
> resulting in the following error messages:
> 
>  # ./bridge_vlan_mcast.sh
>  [...]
>  # ./bridge_vlan_mcast.sh
>  Error: Exclusivity flag on, cannot modify.
>  Error: Exclusivity flag on, cannot modify.
> 
> Solve by deleting the qdiscs during cleanup.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


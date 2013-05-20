Return-Path: <gang.chen@asianux.com>
Message-ID: <5199768E.4060706@asianux.com>
Date: Mon, 20 May 2013 09:04:14 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <5195E53A.4060406@asianux.com> <51992B6F.70309@pandora.be>
In-Reply-To: <51992B6F.70309@pandora.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: netfilter: using strlcpy() instead of
	strncpy()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, stephen@networkplumber.org, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, kaber@trash.net, pablo@netfilter.org

On 05/20/2013 03:43 AM, Bart De Schuymer wrote:
> Op 17/05/2013 10:07, Chen Gang schreef:
>>
>> 'name' has already set all zero when it is defined, so not need let
>> strncpy() to pad it again.
>>
>> 'name' is a string, better always let is NUL terminated, so use
>> strlcpy() instead of strncpy().
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Acked-by: Bart De Schuymer <bdschuym@pandora.be>

Thanks.

-- 
Chen Gang

Asianux Corporation

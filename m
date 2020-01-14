Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f8ZdMZ1BS3aK0eDev5KldCmx7KcdNZN/UQ+7XtW/aqA=;
 b=PUzelXAoI5TjMVnykFB4tdf0SzFYY08HScf9jPX4dI6ofPUxy6MFhNInrqQTFoMQ9x
 JXZ2r+afDsrdLUPHMqOcWONPjxiKx05dTPgRPJdQyH7avOnBoUJWvam/6dWFDjX7L/J0
 B/pdsz/UirHJAgv3AqEYcVkkpb/OIo+PV2iucJBDZEN5HhquzE7vN1IdB7gUL21Za9ag
 uc3IlQTxklGtKmU0kw//wBZJYQgXmzRx9VXyorxyMtjA9KXqtS4PQpnIf6Owf9UpKLlg
 uXNLZF4Ygrj9OvIf/J72+hriWk3+YpidsAZjJVKosvGAc37UYxKXcmGwPAcj2MvfuuX2
 aVJg==
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
 <20200113155233.20771-4-nikolay@cumulusnetworks.com>
 <20200114055544.77a7806f@cakuba.hsd1.ca.comcast.net>
 <076a7a9f-67c6-483a-7b86-f9d70be6ad47@gmail.com>
 <00c4bc6b-2b31-338e-a9ad-b4ea28fc731c@cumulusnetworks.com>
 <344f496a-5d34-4292-b663-97353f6cfa94@cumulusnetworks.com>
 <d5291717-2ce5-97e0-6204-3ff0d27583c5@gmail.com>
 <aa9878d2-22d7-3bcd-deae-cf9bccd4226e@cumulusnetworks.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <473cb0a5-f6ad-ccd3-9186-02713f9cb92f@gmail.com>
Date: Tue, 14 Jan 2020 09:53:39 -0700
MIME-Version: 1.0
In-Reply-To: <aa9878d2-22d7-3bcd-deae-cf9bccd4226e@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/8] net: bridge: vlan: add rtm
 definitions and dump support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 1/14/20 9:50 AM, Nikolay Aleksandrov wrote:
> Ah fair enough, so nlmsg_parse() would be better even without attrs.

that was the intention. It would be a good verification of the theory if
you could run a test with a larger ancillary header.

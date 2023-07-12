Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBBB9611E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAECD61199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1689173643; x=1689260043; bh=Obdgo1ph00bZH
 C4Rao8ThDReb5dSQF1kT34rZ91WFTE=; b=dymLeyf767vKvw7DaKJM0Dii5A7LX
 RZ4Mf/0kHzgeXmHZmrPM/P4gmp1ktIfgjofNJGNgrceHLjHA4Cp35ijtSXY4Vrv7
 MlSSh4C2+ASUxUCkrLVo6tv3zxUmBssdxYQwO5d2LauQEactqFSXJGUxF/nwK8n9
 i0X6943CwY6PJ7eREhzB8KoO6GnSO89c0XnggOu2WlPt3sKAk+N4xhqi+r9yS3nh
 NaK1U8lqchwiIhsVzivDcoVdVMNcABOFc8ENvh+417xBC8WejQi2TmieX5syle+f
 JlJnAMEgUbvW6lZo5i4KIu/G3IwWBmiFOEPyBNpA2re+X9IBWSt2UO1hA==
Date: Wed, 12 Jul 2023 17:53:59 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <ZK6+hwL5p7OVy04X@shredder>
References: <20230711235415.92166-1-kuniyu@amazon.com>
 <ZK69NDM60+N0TTFh@shredder>
 <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
Subject: Re: [Bridge] [PATCH v1 net] bridge: Return an error when enabling
 STP in netns.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Kuniyuki Iwashima <kuni1840@gmail.com>, Harry Coin <hcoin@quietfountain.com>, Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Jul 12, 2023 at 05:52:09PM +0300, Nikolay Aleksandrov wrote:
> I'd prefer this approach to changing user-visible behaviour and potential regressions.
> Just change the warning message.

Yea, I noticed after sending that the message no longer fits :)

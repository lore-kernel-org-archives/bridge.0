Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=8RGf8KCAQJHNAosPeJyYSXlvMYaIyXQSQxyPYx24e/w=;
 b=O9kj/5BfkMHLPyNzZggPZMcEllgF7boU/xWS+3IYd2iSn6L8RaPQ2dY0Txd0Izp/m9
 JU81TlQz21RM0gebie4vMoqbc+qcFCtrE143rAm1rNhopoj2FkINwGh49JwTO18Uam2f
 fTc5kdQzJULFnrkBjig0O4d3NpkujtX4PSiDc604XC581t2YxQFoGzHiiw3/aSBcWXwr
 dv9tu5aE4de/62/Kv+r85Ef3WcEIr8EIjg5LhJsqGVylofJ6547h4sJjTKcjYjkm5TRR
 3Qzz/YLOfaZ5O0M6Hr0w+zQx5p6h2WA+v8C8sKmqRvPsc10Kmg0dVw9BKAs2MJbPfcMa
 3tiw==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <20220224084806.4e85e6b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220223172407.175865-1-troglobit@gmail.com>
 <66dc205f-9f57-61c1-35d9-8712e8d9fe3a@blackwall.org>
 <20220224080611.4e32bac3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <875yp4qlcg.fsf@gmail.com>
 <20220224084806.4e85e6b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date: Thu, 24 Feb 2022 18:27:17 +0100
Message-ID: <8735k8qioa.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH 1/1 net-next] net: bridge: add support for host
	l2 mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

On Thu, Feb 24, 2022 at 08:48, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 24 Feb 2022 17:29:35 +0100 Joachim Wiberg wrote:
>> On Thu, Feb 24, 2022 at 08:06, Jakub Kicinski <kuba@kernel.org> wrote:
>> > On Thu, 24 Feb 2022 13:26:22 +0200 Nikolay Aleksandrov wrote:  
>> >> On 23/02/2022 19:24, Joachim Wiberg wrote:  
>>  [...]  
>> >> It would be nice to add a selftest for L2 entries. You can send it as a follow-up.  
>> > Let's wait for that, also checkpatch says you need to balance brackets
>> > to hold kernel coding style.  
>> Jakub, by "wait for that" do you mean you'd prefer I add the selftests
>> to this?
> Yes, add a selftest as a separate patch but in the same series.

OK, will do, thanks! :)

Regards
 /Joachim
 

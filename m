Return-Path: <john.p.donnelly@oracle.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A2C140500
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3144F40393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=l/tBgtJyJCZLT12iTT1EGC0oCGlKMDMft4Y/dpweAzs=;
 b=dDFVQLk6MUXotBNjy3y+M4KOGKgiA3MUMJ+C/SZVEadG4jp/PCQU03jzcZlZEAiCXREz
 d8A1Q08x2Nq9GWJdtPu5R8wdYsyExWXaGLWA3WB2NZZYF0DG8bf4LGKKf4vjURL/Bq0r
 xUWiS5yxU/PBxL1lABdRLcHXwJ678FS5WFaAvYncOv50jfsTJHeouS4QyMeV992CIYhi
 uWpGhKAeM6LZ+8e4dIDXkX+ap8JLm4f6PxyoUNa8HOEYk2w9EJcvJAAMi58kXzgZBL20
 C0o09ds0IVg7gNwKC3NOfWlhIIMDVMC/vP6HocgJDAXwtcc8Xa1DzYaxIELE+vyjJBn6 JQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/tBgtJyJCZLT12iTT1EGC0oCGlKMDMft4Y/dpweAzs=;
 b=nhf+ppKnYINmgVMNPI1dj8u7oksJvfHwYWChI8d/aVkTkGxQTs9u6L4K7AgII1IX8XD6F9EDkpYVkg7aAqFu1/BkliaOrSs4715P0aoGwhzUsEGfKoFChujMrfjXZmUc7MOgUopG+TH+i6EGraU5G9jyWOJnhyqciPJuipyqLLI=
Message-ID: <bda042e0-8054-41f3-5df6-c39ad424cde2@oracle.com>
Date: Mon, 29 Aug 2022 09:10:10 -0500
Content-Language: en-US
References: <20220820070331.48817-1-harshit.m.mogalapalli@oracle.com>
 <20220820173555.131326-1-fw@strlen.de>
 <93eca5ab-46ee-241a-b01c-a6131b28ba29@oracle.com>
 <20220829140320.GB27814@breakpoint.cc>
From: john.p.donnelly@oracle.com
In-Reply-To: <20220829140320.GB27814@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH nf] netfilter: ebtables: reject blobs that
 don't provide all entry points
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: vegard.nossum@oracle.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, george.kennedy@oracle.com, syzkaller@googlegroups.com, netfilter-devel@vger.kernel.org, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

On 8/29/22 9:03 AM, Florian Westphal wrote:
> john.p.donnelly@oracle.com <john.p.donnelly@oracle.com> wrote:
>> On 8/20/22 12:35 PM, Florian Westphal wrote:
>>> For some reason ebtables reject blobs that provide entry points that are
>>> not supported by the table.
>>>
>>> What it should instead reject is the opposite, i.e. rulesets that
>>> DO NOT provide an entry point that is supported by the table.
>>>
>>> t->valid_hooks is the bitmask of hooks (input, forward ...) that will
>>> see packets.  So, providing an entry point that is not support is
>>> harmless (never called/used), but the reverse is NOT, this will cause
>>> crash because the ebtables traverser doesn't expect a NULL blob for
>>> a location its receiving packets for.
>>>
>>> Instead of fixing all the individual checks, do what iptables is doing and
>>> reject all blobs that doesn't provide the expected hooks.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>>
>> Hi,
>>
>>   Could you please add the panic stack mentioned above  and syzkaller
>> reproducer ID to the commit text ?
> 
> I did not see a reproducer ID.  What ended up in the tree is this:
> 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7997eff82828304b780dc0a39707e1946d6f1ebf__;!!ACWV5N9M2RV99hQ!JxonjgQUi7Mbcd-ouxRwPgu8Jwl6ej2rO4pTvYMtteWexclV5-hciu9e5rgtkXoB7dyAdLCyZ4EQ9HQj$

Thank you !



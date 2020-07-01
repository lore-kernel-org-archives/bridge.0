Return-Path: <borntraeger@de.ibm.com>
References: <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
 <a6792135-3285-0861-014e-3db85ea251dc@i-love.sakura.ne.jp>
 <20200701135324.GS4332@42.do-not-panic.com>
 <8d714a23-bac4-7631-e5fc-f97c20a46083@i-love.sakura.ne.jp>
 <20200701153859.GT4332@42.do-not-panic.com>
 <f9f0f868-e511-990a-2a74-1806ac0cb7ac@de.ibm.com>
 <20200701155819.GU4332@42.do-not-panic.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <eb0b2ec2-52db-81a4-11b0-c0112b39a7aa@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200701155819.GU4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] linux-next: umh: fix processed error when
 UMH_WAIT_PROC is used seems to break linux bridge on s390x (bisected)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 01 Jul 2020 16:03:28 -0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, bfields@fieldses.org, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, dhowells@redhat.com, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net



On 01.07.20 17:58, Luis Chamberlain wrote:
[...]

>>>
>>> Ah, well that would be a different fix required, becuase again,
>>> br_stp_start() does not untangle the correct error today really.
>>> I also I think it would be odd odd that SIGSEGV or another signal 
>>> is what was terminating Christian's bridge stp call, but let's
>>> find out!
>>>
>>> Note we pass 0 to the options to wait so the mistake here could indeed
>>> be that we did not need KWIFSIGNALED(). I was afraid of this prospect...
>>> as it other implications.
>>>
>>> It means we either *open code* all callers, or we handle this in a
>>> unified way on the umh. And if we do handle this in a unified way, it
>>> then begs the question as to *what* do we pass for the signals case and
>>> continued case. Below we just pass the signal, and treat continued as
>>> OK, but treating continued as OK would also be a *new* change as well.
>>>
>>> For instance (this goes just boot tested, but Christian if you can
>>> try this as well that would be appreciated):
>>
>>
>> Does not help, the bridge stays in DOWN state. 
> 
> OK thanks for testing, that was fast! Does your code go through the
> STP kernel path or userpath? If it is taking the STP kernel path
> then this is not the real culprit to your issue then.

I have no idea and I cannot look into this right now. I can test
patches as compile,reboot and test is almost no effort.

FWIW, this is just the network of a KVM guest of libvirts default network
no longer working, maybe you can reproduce this on x86 as well?


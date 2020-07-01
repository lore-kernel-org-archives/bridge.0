Return-Path: <borntraeger@de.ibm.com>
References: <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
 <a6792135-3285-0861-014e-3db85ea251dc@i-love.sakura.ne.jp>
 <20200701135324.GS4332@42.do-not-panic.com>
 <8d714a23-bac4-7631-e5fc-f97c20a46083@i-love.sakura.ne.jp>
 <20200701153859.GT4332@42.do-not-panic.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <f9f0f868-e511-990a-2a74-1806ac0cb7ac@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200701153859.GT4332@42.do-not-panic.com>
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
Date: Wed, 01 Jul 2020 15:49:14 -0000
To: Luis Chamberlain <mcgrof@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, bfields@fieldses.org, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, dhowells@redhat.com, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net



On 01.07.20 17:38, Luis Chamberlain wrote:
> On Wed, Jul 01, 2020 at 11:08:57PM +0900, Tetsuo Handa wrote:
>> On 2020/07/01 22:53, Luis Chamberlain wrote:
>>>> Well, it is not br_stp_call_user() but br_stp_start() which is expecting
>>>> to set sub_info->retval for both KWIFEXITED() case and KWIFSIGNALED() case.
>>>> That is, sub_info->retval needs to carry raw value (i.e. without "umh: fix
>>>> processed error when UMH_WAIT_PROC is used" will be the correct behavior).
>>>
>>> br_stp_start() doesn't check for the raw value, it just checks for err
>>> or !err. So the patch, "umh: fix processed error when UMH_WAIT_PROC is
>>> used" propagates the correct error now.
>>
>> No. If "/sbin/bridge-stp virbr0 start" terminated due to e.g. SIGSEGV
>> (for example, by inserting "kill -SEGV $$" into right after "#!/bin/sh" line),
>> br_stp_start() needs to select BR_KERNEL_STP path. We can't assume that
>> /sbin/bridge-stp is always terminated by exit() syscall (and hence we can't
>> ignore KWIFSIGNALED() case in call_usermodehelper_exec_sync()).
> 
> Ah, well that would be a different fix required, becuase again,
> br_stp_start() does not untangle the correct error today really.
> I also I think it would be odd odd that SIGSEGV or another signal 
> is what was terminating Christian's bridge stp call, but let's
> find out!
> 
> Note we pass 0 to the options to wait so the mistake here could indeed
> be that we did not need KWIFSIGNALED(). I was afraid of this prospect...
> as it other implications.
> 
> It means we either *open code* all callers, or we handle this in a
> unified way on the umh. And if we do handle this in a unified way, it
> then begs the question as to *what* do we pass for the signals case and
> continued case. Below we just pass the signal, and treat continued as
> OK, but treating continued as OK would also be a *new* change as well.
> 
> For instance (this goes just boot tested, but Christian if you can
> try this as well that would be appreciated):


Does not help, the bridge stays in DOWN state. 

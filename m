Return-Path: <borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
 <20200624160953.GH4332@42.do-not-panic.com>
 <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
Message-ID: <fd88506a-bde9-0e63-3473-6b15ed8dbaa2@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
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
Date: Thu, 25 Jun 2020 13:27:08 -0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, bfields@fieldses.org, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, dhowells@redhat.com, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net



On 24.06.20 20:37, Christian Borntraeger wrote:
> 
> 
> On 24.06.20 20:32, Christian Borntraeger wrote:
> [...]> 
>> So the translations look correct. But your change is actually a sematic change
>> if(ret) will only trigger if there is an error
>> if (KWIFEXITED(ret)) will always trigger when the process ends. So we will always overwrite -ECHILD
>> and we did not do it before. 
>>
> 
> So the right fix is
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index f81e8698e36e..a3a3196e84d1 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -154,7 +154,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
>                  * the real error code is already in sub_info->retval or
>                  * sub_info->retval is 0 anyway, so don't mess with it then.
>                  */
> -               if (KWIFEXITED(ret))
> +               if (KWEXITSTATUS(ret))
>                         sub_info->retval = KWEXITSTATUS(ret);
>         }

Ping. Shall I send this as a proper patch or are we merging this fixup in Andrews patch queue?

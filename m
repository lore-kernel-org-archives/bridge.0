Return-Path: <mcgrof@gmail.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20200702194656.GV4332@42.do-not-panic.com>
References: <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
 <a6792135-3285-0861-014e-3db85ea251dc@i-love.sakura.ne.jp>
 <20200701135324.GS4332@42.do-not-panic.com>
 <8d714a23-bac4-7631-e5fc-f97c20a46083@i-love.sakura.ne.jp>
 <20200701153859.GT4332@42.do-not-panic.com>
 <e3f3e501-2cb7-b683-4b85-2002b7603244@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f3e501-2cb7-b683-4b85-2002b7603244@i-love.sakura.ne.jp>
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
Date: Thu, 02 Jul 2020 19:47:01 -0000
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, David Howells <dhowells@redhat.com>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, bfields@fieldses.org, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

On Thu, Jul 02, 2020 at 01:26:53PM +0900, Tetsuo Handa wrote:
> On 2020/07/02 0:38, Luis Chamberlain wrote:
> > @@ -156,6 +156,18 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
> >  		 */
> >  		if (KWIFEXITED(ret))
> >  			sub_info->retval = KWEXITSTATUS(ret);
> > +		/*
> > +		 * Do we really want to be passing the signal, or do we pass
> > +		 * a single error code for all cases?
> > +		 */
> > +		else if (KWIFSIGNALED(ret))
> > +			sub_info->retval = KWTERMSIG(ret);
> 
> No, this is bad. Caller of usermode helper is unable to distinguish exit(9)
> and e.g. SIGKILL'ed by the OOM-killer.

Right, the question is: do we care?

> Please pass raw exit status value.
> 
> I feel that caller of usermode helper should not use exit status value.
> For example, call_sbin_request_key() is checking
> 
>   test_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags) || key_validate(key) < 0
> 
> condition (if usermode helper was invoked) in order to "ignore any errors from
> userspace if the key was instantiated".

For those not familiar with this code path, or if you cannot decipher
the above, the code path in question was:

static int call_sbin_request_key(struct key *authkey, void *aux)                
{
	...
	/* do it */                                                             
	ret = call_usermodehelper_keys(request_key, argv, envp, keyring,        
				       UMH_WAIT_PROC);
	kdebug("usermode -> 0x%x", ret);
	if (ret >= 0) {
		/* ret is the exit/wait code */
		if (test_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags) ||
		    key_validate(key) < 0)
		    ret = -ENOKEY;
		/* ignore any errors from userspace if the key was      
		 * instantiated */  
		 ret = 0;
	}
	...
}

And the umh patch "umh: fix processed error when UMH_WAIT_PROC is used"
changed this to:

-       if (ret >= 0) {
+       if (ret != 0) {

Prior to the patch negative return values from userspace were still
being captured, and likewise signals, but the error value was not
raw, not the actual value. After the patch, since we check for ret != 0
we still upkeep the sanity check for any error, correct the error value,
but as you noted signals were ignored as I made the wrong assumption
we would ignore them. The umh sub_info->retval is set after my original
patch only if KWIFSIGNALED(ret)), and ignored signals, and so that
would be now capitured with the additional KWIFSIGNALED(ret)) check.

The question still stands:

Do we want to open code all these checks or simply wrap them up in
the umh. If we do the later, as you note exit(9) and a SIGKILL will
be the same to the inspector in the kernel. But do we care?

Do we really want umh callers differntiatin between signals and exit values?

The alternative to making a compromise is using generic wrappers for
things which make sense and letting the callers use those.

  Luis

> > +		/* Same here */
> > +		else if (KWIFSTOPPED((ret)))
> > +			sub_info->retval = KWSTOPSIG(ret);
> > +		/* And are we really sure we want this? */
> > +		else if (KWIFCONTINUED((ret)))
> > +			sub_info->retval = 0;
> >  	}
> >  
> >  	/* Restore default kernel sig handler */
> > 
> 

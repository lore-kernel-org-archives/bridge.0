Return-Path: <mcgrof@gmail.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20200701153859.GT4332@42.do-not-panic.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d714a23-bac4-7631-e5fc-f97c20a46083@i-love.sakura.ne.jp>
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
Date: Wed, 01 Jul 2020 15:39:04 -0000
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, bfields@fieldses.org, keyrings@vger.kernel.org, mcgrof@kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, dhowells@redhat.com, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

On Wed, Jul 01, 2020 at 11:08:57PM +0900, Tetsuo Handa wrote:
> On 2020/07/01 22:53, Luis Chamberlain wrote:
> >> Well, it is not br_stp_call_user() but br_stp_start() which is expecting
> >> to set sub_info->retval for both KWIFEXITED() case and KWIFSIGNALED() case.
> >> That is, sub_info->retval needs to carry raw value (i.e. without "umh: fix
> >> processed error when UMH_WAIT_PROC is used" will be the correct behavior).
> > 
> > br_stp_start() doesn't check for the raw value, it just checks for err
> > or !err. So the patch, "umh: fix processed error when UMH_WAIT_PROC is
> > used" propagates the correct error now.
> 
> No. If "/sbin/bridge-stp virbr0 start" terminated due to e.g. SIGSEGV
> (for example, by inserting "kill -SEGV $$" into right after "#!/bin/sh" line),
> br_stp_start() needs to select BR_KERNEL_STP path. We can't assume that
> /sbin/bridge-stp is always terminated by exit() syscall (and hence we can't
> ignore KWIFSIGNALED() case in call_usermodehelper_exec_sync()).

Ah, well that would be a different fix required, becuase again,
br_stp_start() does not untangle the correct error today really.
I also I think it would be odd odd that SIGSEGV or another signal 
is what was terminating Christian's bridge stp call, but let's
find out!

Note we pass 0 to the options to wait so the mistake here could indeed
be that we did not need KWIFSIGNALED(). I was afraid of this prospect...
as it other implications.

It means we either *open code* all callers, or we handle this in a
unified way on the umh. And if we do handle this in a unified way, it
then begs the question as to *what* do we pass for the signals case and
continued case. Below we just pass the signal, and treat continued as
OK, but treating continued as OK would also be a *new* change as well.

For instance (this goes just boot tested, but Christian if you can
try this as well that would be appreciated):

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index bba06befbff5..d1898f5dd1fc 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -105,10 +105,12 @@ extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 
 /* Only add helpers for actual use cases in the kernel */
 #define KWEXITSTATUS(status)		(__KWEXITSTATUS(status))
+#define KWTERMSIG(status)		(__KWTERMSIG(status))
+#define KWSTOPSIG(status)		(__KWSTOPSIG(status))
 #define KWIFEXITED(status)		(__KWIFEXITED(status))
-
-/* Nonzero if STATUS indicates normal termination.  */
-#define __KWIFEXITED(status)     (__KWTERMSIG(status) == 0)
+#define KWIFSIGNALED(status)		(__KWIFSIGNALED(status))
+#define KWIFSTOPPED(status)		(__KWIFSTOPPED(status))
+#define KWIFCONTINUED(status)		(__KWIFCONTINUED(status))
 
 /* If KWIFEXITED(STATUS), the low-order 8 bits of the status.  */
 #define __KWEXITSTATUS(status)   (((status) & 0xff00) >> 8)
@@ -116,6 +118,24 @@ extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 /* If KWIFSIGNALED(STATUS), the terminating signal.  */
 #define __KWTERMSIG(status)      ((status) & 0x7f)
 
+/* If KWIFSTOPPED(STATUS), the signal that stopped the child.  */
+#define __KWSTOPSIG(status)      __KWEXITSTATUS(status)
+
+/* Nonzero if STATUS indicates normal termination.  */
+#define __KWIFEXITED(status)     (__KWTERMSIG(status) == 0)
+
+/* Nonzero if STATUS indicates termination by a signal.  */
+#define __KWIFSIGNALED(status) \
+	(((signed char) (((status) & 0x7f) + 1) >> 1) > 0)
+
+/* Nonzero if STATUS indicates the child is stopped.  */
+#define __KWIFSTOPPED(status)    (((status) & 0xff) == 0x7f)
+
+/* Nonzero if STATUS indicates the child continued after a stop. */
+#define __KWIFCONTINUED(status) ((status) == __KW_CONTINUED)
+
+#define __KW_CONTINUED		0xffff
+
 extern void free_task(struct task_struct *tsk);
 
 /* sched_exec is called by processes performing an exec */
diff --git a/kernel/umh.c b/kernel/umh.c
index f81e8698e36e..c98fb1ed90c9 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -156,6 +156,18 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 		 */
 		if (KWIFEXITED(ret))
 			sub_info->retval = KWEXITSTATUS(ret);
+		/*
+		 * Do we really want to be passing the signal, or do we pass
+		 * a single error code for all cases?
+		 */
+		else if (KWIFSIGNALED(ret))
+			sub_info->retval = KWTERMSIG(ret);
+		/* Same here */
+		else if (KWIFSTOPPED((ret)))
+			sub_info->retval = KWSTOPSIG(ret);
+		/* And are we really sure we want this? */
+		else if (KWIFCONTINUED((ret)))
+			sub_info->retval = 0;
 	}
 
 	/* Restore default kernel sig handler */

/* linux */
#define SYSCONFDIR	"/etc"
#define SBINDIR		"/sbin"
#define LIBDIR		"/lib"
#define LIBEXECDIR	"/libexec"
#define DBDIR		"/var/db"
#define RUNDIR		"/var/run"
#include		<asm/types.h> /* fix broken headers */
#include		<sys/socket.h> /* fix broken headers */
#include		<linux/rtnetlink.h>
#define HAVE_NL80211_H
#include		"compat/arc4random.h"
#include		"compat/arc4random_uniform.h"
#include		"compat/closefrom.h"
#include		"compat/strtoi.h"
#define HAVE_SYS_QUEUE_H
#include		"compat/endian.h"
